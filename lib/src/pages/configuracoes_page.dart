import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({Key? key}) : super(key: key);

  @override
  _ConfiguracoesPageState createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences storage;
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;

  final CHAVE_NOME_USUARIO = "CHAVE_NOME_USUARIO";
  final CHAVE_ALTURA = "CHAVE_ALTURA";
  final CHAVE_RECEBER_NOTIFICACOES = "CHAVE_RECEBER_NOTIFICACOES";
  final CHAVE_TEMA_ESCURO = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuarioController.text = storage.getString(CHAVE_NOME_USUARIO) ?? '';
      alturaController.text = (storage.getDouble(CHAVE_ALTURA) ?? 0).toString();
      receberNotificacoes =
          storage.getBool(CHAVE_RECEBER_NOTIFICACOES) ?? false;
      temaEscuro = storage.getBool(CHAVE_TEMA_ESCURO) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Container(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: const InputDecoration(hintText: "Nome usuário"),
                  controller: nomeUsuarioController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "altura"),
                  controller: alturaController,
                ),
              ),
              SwitchListTile(
                title: const Text('Receber notificações'),
                value: receberNotificacoes,
                onChanged: (bool value) {
                  setState(() {
                    receberNotificacoes = value;
                  });
                },
              ),
              SwitchListTile(
                title: const Text('Tema escuro'),
                value: temaEscuro,
                onChanged: (bool value) {
                  setState(() {
                    temaEscuro = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();

                      try {
                        await storage.setDouble(
                          CHAVE_ALTURA,
                          double.parse(alturaController.text),
                        );
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                title: const Text("Meu App"),
                                content: const Text(
                                    "Favor informar uma altura válida!"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              );
                            });
                        return;
                      }

                      await storage.setString(
                          CHAVE_NOME_USUARIO, nomeUsuarioController.text);

                      await storage.setBool(
                          CHAVE_RECEBER_NOTIFICACOES, receberNotificacoes);
                      await storage.setBool(CHAVE_TEMA_ESCURO, temaEscuro);

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      backgroundColor: MaterialStateProperty.all(Colors.amber),
                    ),
                    child: const Text('Salvar')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
