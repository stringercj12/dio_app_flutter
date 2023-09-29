import 'package:dio_app_flutter/src/model/tarefa_sqlite_model.dart';
import 'package:dio_app_flutter/src/repositories/sqlite/sqlite_database.dart';

class TarefaSqliteRepository {
  Future<List<TarefaSqliteModel>> obterDados(bool apenasNaoConcluidos) async {
    List<TarefaSqliteModel> tarefas = [];
    var db = await SQliteDatabase().obterDatabase();
    var result = await db.rawQuery(
      apenasNaoConcluidos
          ? 'SELECT * FROM tarefas WHERE concluido = 0'
          : 'SELECT * FROM tarefas',
    );

    for (var element in result) {
      tarefas.add(
        TarefaSqliteModel(
          int.parse(element['id'].toString()),
          element['descricao'].toString(),
          element['concluido'] == 1,
        ),
      );
    }

    return tarefas;
  }

  Future<void> salvar(TarefaSqliteModel tarefaSqliteModel) async {
    var db = await SQliteDatabase().obterDatabase();
    db.rawInsert(
      'INSERT INTO tarefas (descricao,concluido) VALUES (?,?)',
      [tarefaSqliteModel.descricao, tarefaSqliteModel.concluido],
    );
  }

  Future<void> atualizar(TarefaSqliteModel tarefaSqliteModel) async {
    var db = await SQliteDatabase().obterDatabase();
    db.rawInsert(
      'UPDATE tarefas SET descricao = ?,concluido = ? WHERE id = ?',
      [
        tarefaSqliteModel.descricao,
        tarefaSqliteModel.concluido ? 1 : 0,
        tarefaSqliteModel.id
      ],
    );
  }

  Future<void> remover(int id) async {
    var db = await SQliteDatabase().obterDatabase();
    db.rawInsert(
      'DELETE FROM tarefas WHERE id = ?',
      [id],
    );
  }
}
