import 'package:dio_app_flutter/src/repositories/nivel_repository.dart';
import 'package:flutter/material.dart';

import '../../hared/widgets/textlabel_.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({super.key});

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  var nomeController = TextEditingController(text: '');
  var dataNascimentoController = TextEditingController(text: '');
  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var niveis = [];
  var nivelSelecionado = "";

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Meus dados'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextLabel(texto: 'Nome'),
              TextField(
                controller: nomeController,
              ),
              const TextLabel(texto: 'Data de nascimento'),
              TextField(
                readOnly: true,
                controller: dataNascimentoController,
                onTap: () async {
                  var data = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1, 1),
                    firstDate: DateTime(1900, 1, 1),
                    lastDate: DateTime(2045, 12, 1),
                  );

                  if (data != null) {
                    dataNascimentoController.text = data.toString();
                    dataNascimento = data;
                  }
                },
              ),
              const TextLabel(texto: 'Nivel de experiência'),
              Column(
                children: niveis
                    .map(
                      (nivel) => RadioListTile(
                        dense: true,
                        title: Text(nivel.toString()),
                        value: nivel.toString(),
                        selected: nivelSelecionado == nivel,
                        groupValue: nivelSelecionado,
                        onChanged: (value) {
                          setState(() {
                            nivelSelecionado = value.toString();
                          });
                          debugPrint(value.toString());
                        },
                      ),
                    )
                    .toList(),
              ),
              TextButton(
                onPressed: () {
                  debugPrint(nomeController.text);
                  debugPrint(dataNascimento.toString());
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ));
  }
}
