import 'package:flutter/material.dart';
import 'package:dio_app_flutter/src/model/tarefas/tarefas_back4app_model.dart';
import 'package:dio_app_flutter/src/repositories/back4app/tarefas_back4app_repository.dart';

class TarefaBack4AppPage extends StatefulWidget {
  const TarefaBack4AppPage({Key? key}) : super(key: key);

  @override
  _TarefaBack4AppPageState createState() => _TarefaBack4AppPageState();
}

class _TarefaBack4AppPageState extends State<TarefaBack4AppPage> {
  TarefasBack4AppRepository tarefasBack4AppRepository =
      TarefasBack4AppRepository();
  var _tarefasBack4app = TarefasBack4appModel([]);
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;
  var carregando = false;

  void obterTarefas() async {
    setState(() {
      carregando = true;
    });
    _tarefasBack4app =
        await tarefasBack4AppRepository.obterTarefas(apenasNaoConcluidos);

    setState(() {
      carregando = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    obterTarefas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas HTTP'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          descricaoController.text = "";
          showDialog(
            context: context,
            builder: (BuildContext buildContext) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Adicionar Tarefa'),
                content: TextField(
                  controller: descricaoController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint(descricaoController.text);
                      tarefasBack4AppRepository.criarTarefa(
                        TarefaBack4appModel.criar(
                          descricaoController.text,
                          false,
                        ),
                      );
                      Navigator.pop(context);
                      setState(() {});
                      obterTarefas();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tarefa adicionada'),
                        ),
                      );
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Filtrar apenas não concluídos'),
                  Switch(
                    value: apenasNaoConcluidos,
                    onChanged: (bool value) {
                      apenasNaoConcluidos = value;
                      obterTarefas();
                    },
                  ),
                ],
              ),
            ),
            carregando
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: _tarefasBack4app.tarefas.length,
                      itemBuilder: (BuildContext buildContext, int index) {
                        var tarefa = _tarefasBack4app.tarefas[index];
                        return Dismissible(
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            await tarefasBack4AppRepository
                                .remover(tarefa.objectId);
                            obterTarefas();
                          },
                          key: Key(tarefa.objectId.toString()),
                          child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                tarefa.concluido = value;
                                await tarefasBack4AppRepository
                                    .atualizarTarefa(tarefa);
                                obterTarefas();
                              },
                              value: tarefa.concluido,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
