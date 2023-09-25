// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES {
  CHAVE_DADOS_CADASTRAIS_NOME,
  CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO,
  CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_LINGUAGENS,
  CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA,
  CHAVE_DADOS_CADASTRAIS_SALARIO,
  CHAVE_NOME_USUARIO,
  CHAVE_ALTURA,
  CHAVE_RECEBER_NOTIFICACOES,
  CHAVE_TEMA_ESCURO,
  CHAVE_NUMERO_ALEATORIO,
  CHAVE_QUANTIDADE_DE_CLIQUES,
}

class AppStorageService {
  Future<void> removeNumerosAletorios() async {
    await _remove(STORAGE_CHAVES.CHAVE_NUMERO_ALEATORIO.toString());
  }

  Future<void> removeQuantidadeDeCliques() async {
    await _remove(STORAGE_CHAVES.CHAVE_QUANTIDADE_DE_CLIQUES.toString());
  }

  Future<void> setNumeroAleatorio(int value) async {
    await _setInt(STORAGE_CHAVES.CHAVE_NUMERO_ALEATORIO.toString(), value);
  }

  Future<int> getNumeroAleatorio() async {
    return _getInt(STORAGE_CHAVES.CHAVE_NUMERO_ALEATORIO.toString());
  }

  Future<void> setQuantidadeDeCliques(int value) async {
    await _setInt(STORAGE_CHAVES.CHAVE_QUANTIDADE_DE_CLIQUES.toString(), value);
  }

  Future<int> getQuantidadeDeCliques() async {
    return _getInt(STORAGE_CHAVES.CHAVE_QUANTIDADE_DE_CLIQUES.toString());
  }

  Future<void> setDadosCadastraisNomeUsuario(String nome) async {
    await _setString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString(), nome);
  }

  Future<String> dadosCadastraisNomeUsuario() async {
    return _getString(STORAGE_CHAVES.CHAVE_NOME_USUARIO.toString());
  }

  Future<void> setDadosCadastraisAltura(double altura) async {
    await _setDouble(
      STORAGE_CHAVES.CHAVE_ALTURA.toString(),
      altura,
    );
  }

  Future<double> dadosCadastraisAltura() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_ALTURA.toString());
  }

  Future<void> setDadosCadastraisReceberNotificacoes(
      bool receberNotificacoes) async {
    await _setBool(
      STORAGE_CHAVES.CHAVE_RECEBER_NOTIFICACOES.toString(),
      receberNotificacoes,
    );
  }

  Future<bool> dadosCadastraisReceberNotificacoes() async {
    return _getBool(STORAGE_CHAVES.CHAVE_RECEBER_NOTIFICACOES.toString());
  }

  Future<void> setDadosCadastraisTemaEscuro(bool temaEscuro) async {
    await _setBool(
      STORAGE_CHAVES.CHAVE_TEMA_ESCURO.toString(),
      temaEscuro,
    );
  }

  Future<bool> dadosCadastraisTemaEscuro() async {
    return _getBool(STORAGE_CHAVES.CHAVE_TEMA_ESCURO.toString());
  }

  Future<void> setDadosCadastraisNome(String nome) async {
    await _setString(
        STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString(), nome);
  }

  Future<String> dadosCadastraisNome() async {
    return _getString(STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NOME.toString());
  }

  Future<void> setDadosCadastraisDataNascimento(DateTime dataNascimento) async {
    _setString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString(),
      dataNascimento.toString(),
    );
  }

  Future<String> dadosCadastraisDataNascimento() async {
    return _getString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_DATA_NASCIMENTO.toString(),
    );
  }

  Future<void> setDadosCadastraisNivelExperiencia(
      String nivelExperiencia) async {
    _setString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString(),
      nivelExperiencia.toString(),
    );
  }

  Future<String> dadosCadastraisNivelExperiencia() async {
    return _getString(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_NIVEL_EXPERIENCIA.toString(),
    );
  }

  Future<void> setDadosCadastraisLinguagens(List<String> linguagens) async {
    _setStringList(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString(),
      linguagens,
    );
  }

  Future<List<String>> dadosCadastraisLinguagens() async {
    return _getStringList(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_LINGUAGENS.toString(),
    );
  }

  Future<void> setDadosCadastraisTempoExperiencia(int nivelExperiencia) async {
    _setInt(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString(),
      nivelExperiencia,
    );
  }

  Future<int> dadosCadastraisTempoExperiencia() async {
    return _getInt(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_TEMPO_EXPERIENCIA.toString(),
    );
  }

  Future<void> setDadosCadastraisSalario(double salario) async {
    _setDouble(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString(),
      salario,
    );
  }

  Future<double> dadosCadastraisSalario() async {
    return _getDouble(
      STORAGE_CHAVES.CHAVE_DADOS_CADASTRAIS_SALARIO.toString(),
    );
  }

  Future<void> _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  Future<void> _setStringList(String chave, List<String> value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setStringList(chave, value);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  Future<void> _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  Future<void> _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }

  Future<void> _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }

  Future<bool> _remove(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.remove(chave);
  }
}
