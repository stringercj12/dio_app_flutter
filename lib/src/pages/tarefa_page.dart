import 'package:dio_app_flutter/src/model/tarefa.dart';
import 'package:dio_app_flutter/src/repositories/tarefa_repository.dart';
import 'package:flutter/material.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({Key? key}) : super(key: key);

  @override
  _TarefaPageState createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefaRepository = TarefaRepository();
  var _tarefas = const <Tarefa>[];
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;

  void obterTarefas() async {
    if (apenasNaoConcluidos) {
      _tarefas = await tarefaRepository.listarNaoConcluida();
    } else {
      _tarefas = await tarefaRepository.listarTarefas();
    }
    setState(() {});
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
                      tarefaRepository
                          .adicionar(Tarefa(descricaoController.text, false));
                      Navigator.pop(context);
                      setState(() {});
                      obterTarefas();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tarefa adicionada'),
                          duration: Duration(seconds: 200),
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
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await tarefaRepository.remover(tarefa.getId());
                      obterTarefas();
                    },
                    key: Key(tarefa.getId()),
                    child: ListTile(
                      title: Text(tarefa.getDescricao()),
                      trailing: Switch(
                        onChanged: (bool value) async {
                          await tarefaRepository.alterar(tarefa.getId(), value);
                          obterTarefas();
                        },
                        value: tarefa.getConcluido(),
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
