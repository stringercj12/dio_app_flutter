import 'package:dio_app_flutter/src/model/tarefa.dart';
import 'package:dio_app_flutter/src/model/tarefa_sqlite_model.dart';
import 'package:dio_app_flutter/src/repositories/sqlite/tarefa_sqlite_repository.dart';
import 'package:dio_app_flutter/src/repositories/tarefa_repository.dart';
import 'package:flutter/material.dart';

class TarefaSqlitePage extends StatefulWidget {
  const TarefaSqlitePage({Key? key}) : super(key: key);

  @override
  _TarefaSqlitePageState createState() => _TarefaSqlitePageState();
}

class _TarefaSqlitePageState extends State<TarefaSqlitePage> {
  TarefaSqliteRepository tarefaSqliteRepository = TarefaSqliteRepository();
  var _tarefas = const <TarefaSqliteModel>[];
  var descricaoController = TextEditingController();
  var apenasNaoConcluidos = false;

  void obterTarefas() async {
    _tarefas = await tarefaSqliteRepository.obterDados(apenasNaoConcluidos);
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
                      tarefaSqliteRepository.salvar(
                        TarefaSqliteModel(0, descricaoController.text, false),
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
            Expanded(
              child: ListView.builder(
                itemCount: _tarefas.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  var tarefa = _tarefas[index];
                  return Dismissible(
                    onDismissed: (DismissDirection dismissDirection) async {
                      await tarefaSqliteRepository.remover(tarefa.id);
                      obterTarefas();
                    },
                    key: Key(tarefa.id.toString()),
                    child: ListTile(
                      title: Text(tarefa.descricao),
                      trailing: Switch(
                        onChanged: (bool value) async {
                          await tarefaSqliteRepository.atualizar(
                            TarefaSqliteModel(
                              tarefa.id,
                              tarefa.descricao,
                              tarefa.concluido,
                            ),
                          );
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
