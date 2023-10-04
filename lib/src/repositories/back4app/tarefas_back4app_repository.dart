import 'package:dio_app_flutter/src/model/tarefas/tarefas_back4app_model.dart';
import 'package:dio_app_flutter/src/repositories/back4app/back4app_custom_dio.dart';

class TarefasBack4AppRepository {
  final back4AppCustomDio = Back4AppCustomDio();

  Future<TarefasBack4appModel> obterTarefas(bool tarefasNaoConcluidas) async {
    var url = '/tarefas';
    if (tarefasNaoConcluidas) {
      url = '$url?where={"concluido":false}';
    }
    var result = await back4AppCustomDio.dio.get(url);

    return TarefasBack4appModel.fromJson(result.data);
  }

  Future<void> criarTarefa(TarefaBack4appModel tarefaBack4appModel) async {
    try {
      await back4AppCustomDio.dio
          .post('/tarefas', data: tarefaBack4appModel.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> atualizarTarefa(TarefaBack4appModel tarefaBack4appModel) async {
    try {
      await back4AppCustomDio.dio.put(
          '/tarefas/${tarefaBack4appModel.objectId}',
          data: tarefaBack4appModel.toJsonEndPoint());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remover(String objectId) async {
    try {
      await back4AppCustomDio.dio.delete('/tarefas/$objectId');
    } catch (e) {
      rethrow;
    }
  }
}
