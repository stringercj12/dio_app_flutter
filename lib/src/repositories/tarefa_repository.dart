import 'package:dio_app_flutter/src/model/tarefa.dart';

class TarefaRepository {
  final List<Tarefa> _tarefas = [];

  Future<void> adicionar(Tarefa tarefa) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _tarefas.add(tarefa);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 100));

    var tarefa = _tarefas.where((tarefa) => tarefa.getId() == id).first;

    tarefa.setConcluido(concluido);
  }

  Future<void> remover(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    var tarefa = _tarefas.where((tarefa) => tarefa.getId() == id).first;
    _tarefas.remove(tarefa);
  }

  Future<List<Tarefa>> listarTarefas() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _tarefas;
  }

  Future<List<Tarefa>> listarNaoConcluida() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _tarefas.where((tarefa) => !tarefa.getConcluido()).toList();
  }
}
