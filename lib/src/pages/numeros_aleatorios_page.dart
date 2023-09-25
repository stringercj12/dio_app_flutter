import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int? numeroGerado = 0;
  int? quantidadeDeCliques = 0;
  final CHAVE_NUMERO_ALEATORIO = "numero_aleatorio";
  final CHAVE_QUANTIDADE_DE_CLIQUES = "quantidade_de_cliques";

  late SharedPreferences storage;

  void carregarDados() async {
    storage = await SharedPreferences.getInstance();

    setState(() {
      numeroGerado = storage.getInt(CHAVE_NUMERO_ALEATORIO);
      quantidadeDeCliques = storage.getInt(CHAVE_QUANTIDADE_DE_CLIQUES);
    });
    debugPrint(numeroGerado.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    carregarDados();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gerador de números aleatórios'),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == null
                    ? 'Nenhum número gerador'
                    : numeroGerado.toString(),
                style: const TextStyle(
                  fontSize: 28,
                ),
              ),
              Text(
                quantidadeDeCliques == null
                    ? 'Nenhum clique efetuado'
                    : quantidadeDeCliques.toString(),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () async {
                  // Remove data for the 'counter' key.
                  await storage.remove(CHAVE_NUMERO_ALEATORIO);
                  await storage.remove(CHAVE_QUANTIDADE_DE_CLIQUES);
                  carregarDados();
                  setState(() {});
                },
                child: const Text('Limpar'),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            var random = Random();
            setState(() {
              numeroGerado = random.nextInt(1000);
              quantidadeDeCliques = (quantidadeDeCliques ?? 0) + 1;
            });
            storage.setInt(CHAVE_NUMERO_ALEATORIO, numeroGerado!);
            storage.setInt(CHAVE_QUANTIDADE_DE_CLIQUES, quantidadeDeCliques!);
          },
        ),
      ),
    );
  }
}
