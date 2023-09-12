import 'package:flutter/material.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({super.key});

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  TextEditingController nomeController = TextEditingController(text: '');
  TextEditingController dataNascimentoController =
      TextEditingController(text: '');

  Text returnText(String texto) {
    return Text(
      texto,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
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
              returnText('Nome'),
              TextField(
                controller: nomeController,
              ),
              const SizedBox(
                height: 10,
              ),
              returnText('Data de nascimento'),
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
                  }
                },
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Salvar'),
              ),
            ],
          ),
        ));
  }
}
