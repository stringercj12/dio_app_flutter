import 'dart:ffi';

import 'package:flutter/material.dart';

class CalcImcPage extends StatefulWidget {
  const CalcImcPage({super.key});

  @override
  State<CalcImcPage> createState() => _CalcImcPageState();
}

class _CalcImcPageState extends State<CalcImcPage> {
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var imc = "";
  var _infoCard = const Text('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Vamos calcular seu IMC'),
            const SizedBox(
              height: 50,
            ),
            const Text('Informe seu peso?'),
            TextField(
              controller: pesoController,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('Informe sua altura?'),
            TextField(
              controller: alturaController,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (pesoController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Informe seu peso (kg)'),
                      ),
                    );
                    return;
                  }
                  if (alturaController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Informe sua altura (metro e cm)'),
                      ),
                    );
                    return;
                  }
                  double peso = double.parse(pesoController.text);
                  double altura = double.parse(alturaController.text);
                  double imc = peso / (altura * altura);

                  if (imc < 18.6) {
                    _infoCard = Text(
                      'Abaixo do Peso (${imc.toStringAsPrecision(3)})',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    );
                  } else if (imc >= 18.6 && imc < 24.9) {
                    _infoCard = Text(
                      'Peso Ideal (${imc.toStringAsPrecision(3)})',
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    );
                  } else if (imc >= 24.9 && imc < 29.9) {
                    _infoCard = Text(
                      'Levemente Acima do Peso (${imc.toStringAsPrecision(3)})',
                      style: TextStyle(
                        color: Colors.red[50],
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    );
                  } else if (imc >= 29.9 && imc < 34.9) {
                    _infoCard = Text(
                      'Obesidade Grau I (${imc.toStringAsPrecision(3)})',
                      style: TextStyle(
                        color: Colors.red[100],
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    );
                  } else if (imc >= 34.9 && imc < 39.9) {
                    _infoCard = Text(
                      'Obesidade Grau II (${imc.toStringAsPrecision(3)})',
                      style: TextStyle(
                        color: Colors.red[300],
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    );
                  } else if (imc >= 40) {
                    _infoCard = Text(
                      'Obesidade Grau III (${imc.toStringAsPrecision(3)})',
                      style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                ),
                child: const Text(
                  'Calcular IMC',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: _infoCard,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
