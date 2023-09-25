import 'dart:math';

import 'package:dio_app_flutter/src/services/app_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosHivePage extends StatefulWidget {
  const NumerosAleatoriosHivePage({super.key});

  @override
  State<NumerosAleatoriosHivePage> createState() =>
      _NumerosAleatoriosHivePageState();
}

class _NumerosAleatoriosHivePageState extends State<NumerosAleatoriosHivePage> {
  int? numeroGerado = 0;
  int? quantidadeDeCliques = 0;

  late Box boxNumerosAleatorios;

  void carregarDados() async {
    if (Hive.isBoxOpen("box_numeros_aleatorios")) {
      boxNumerosAleatorios = Hive.box("box_numeros_aleatorios");
    } else {
      boxNumerosAleatorios = await Hive.openBox("box_numeros_aleatorios");
    }
    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    quantidadeDeCliques = boxNumerosAleatorios.get('quantidadeDeCliques') ?? 0;

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
          title: const Text('Hive - Gerador de números aleatórios'),
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
                  await boxNumerosAleatorios.clear();
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
            boxNumerosAleatorios.put('numeroGerado', numeroGerado!);
            boxNumerosAleatorios.put(
                'quantidadeDeCliques', quantidadeDeCliques!);
          },
        ),
      ),
    );
  }
}
