import 'package:dio_app_flutter/src/repositories/linguagens_repository.dart';
import 'package:dio_app_flutter/src/repositories/nivel_repository.dart';
import 'package:flutter/material.dart';

import '../../shared/widgets/textlabel_.dart';

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
  var linguagemRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  var linguagensSelecionadas = [];
  var nivelSelecionado = "";
  double salarioEscolhido = 0;
  int tempoExperiencia = 0;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagemRepository.retornaLinguagens();
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
          child: ListView(
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
              const TextLabel(texto: 'Linguagens preferidas'),
              Column(
                children: linguagens
                    .map(
                      (linguagem) => CheckboxListTile(
                        dense: true,
                        title: Text(linguagem),
                        value: linguagensSelecionadas.contains(linguagem),
                        onChanged: (bool? value) {
                          if (value!) {
                            setState(() {
                              linguagensSelecionadas.add(linguagem);
                            });
                          } else {
                            setState(() {
                              linguagensSelecionadas.remove(linguagem);
                            });
                          }
                        },
                      ),
                    )
                    .toList(),
              ),
              TextLabel(
                texto:
                    'Pretenção salarial R\$ ${salarioEscolhido.round().toString()}',
              ),
              Slider(
                  min: 0,
                  max: 10000,
                  value: salarioEscolhido,
                  onChanged: (double value) {
                    setState(() {
                      salarioEscolhido = value;
                    });
                  }),
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
