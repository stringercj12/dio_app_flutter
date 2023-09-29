import 'package:dio_app_flutter/src/services/app_storage_service.dart';
import 'package:flutter/material.dart';

class ConfiguracoesSharedPreferencesPage extends StatefulWidget {
  const ConfiguracoesSharedPreferencesPage({Key? key}) : super(key: key);

  @override
  _ConfiguracoesSharedPreferencesPageState createState() =>
      _ConfiguracoesSharedPreferencesPageState();
}

class _ConfiguracoesSharedPreferencesPageState
    extends State<ConfiguracoesSharedPreferencesPage> {
  AppStorageService storage = AppStorageService();
  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String? nomeUsuario;
  double? altura;
  bool receberNotificacoes = false;
  bool temaEscuro = false;

  bool salvando = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.dadosCadastraisNomeUsuario();
    alturaController.text = (await storage.dadosCadastraisAltura()).toString();
    receberNotificacoes = await storage.dadosCadastraisReceberNotificacoes();
    temaEscuro = await storage.dadosCadastraisTemaEscuro();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurações'),
        ),
        body: Container(
          child: salvando
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        decoration:
                            const InputDecoration(hintText: "Nome usuário"),
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
                              await storage.setDadosCadastraisAltura(
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

                            await storage.setDadosCadastraisNomeUsuario(
                                nomeUsuarioController.text);
                            await storage.setDadosCadastraisReceberNotificacoes(
                                receberNotificacoes);
                            await storage
                                .setDadosCadastraisTemaEscuro(temaEscuro);

                            setState(() {
                              salvando = true;
                            });

                            Future.delayed(const Duration(seconds: 2), () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Dados salvos com sucesso'),
                                ),
                              );
                              setState(() {
                                salvando = false;
                              });
                              Navigator.pop(context);
                            });
                          },
                          style: ButtonStyle(
                            alignment: Alignment.center,
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber),
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
