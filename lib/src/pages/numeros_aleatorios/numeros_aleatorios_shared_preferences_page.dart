import 'dart:math';

import 'package:dio_app_flutter/src/services/app_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosSharedPreferencesPage extends StatefulWidget {
  const NumerosAleatoriosSharedPreferencesPage({super.key});

  @override
  State<NumerosAleatoriosSharedPreferencesPage> createState() =>
      _NumerosAleatoriosSharedPreferencesPageState();
}

class _NumerosAleatoriosSharedPreferencesPageState
    extends State<NumerosAleatoriosSharedPreferencesPage> {
  int? numeroGerado = 0;
  int? quantidadeDeCliques = 0;

  AppStorageService storage = AppStorageService();

  void carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    quantidadeDeCliques = await storage.getQuantidadeDeCliques();

    setState(() {});
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
          title: const Text('SP - Gerador de números aleatórios'),
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
                  await storage.removeNumerosAletorios();
                  await storage.removeQuantidadeDeCliques();
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
            storage.setNumeroAleatorio(numeroGerado!);
            storage.setQuantidadeDeCliques(quantidadeDeCliques!);
          },
        ),
      ),
    );
  }
}
