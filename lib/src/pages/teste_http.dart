import 'package:dio_app_flutter/src/model/viacep_model.dart';
import 'package:dio_app_flutter/src/repositories/via_cep_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:http/http.dart' as http;

class TesteHttpPage extends StatefulWidget {
  const TesteHttpPage({super.key});

  @override
  State<TesteHttpPage> createState() => _TesteHttpPageState();
}

class _TesteHttpPageState extends State<TesteHttpPage> {
  var cepController = TextEditingController(text: "");
  var viacepModel = ViaCEPModel();
  var viaCepRepository = ViaCepRepository();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HTTP'),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
              debugPrint('Menu my app');
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Consulta de CEP",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                maxLength: 8,
                onChanged: (String value) async {
                  // var cep = value.trim().replaceAll("-", "");
                  var cep = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (cep.length == 8) {
                    setState(() {
                      loading = true;
                    });
                    FocusScope.of(context).requestFocus(FocusNode());
                    viacepModel = await viaCepRepository.obterCEP(cep);
                  }

                  setState(() {
                    loading = false;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                viacepModel.logradouro ?? "",
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                "${viacepModel.localidade ?? ""} - ${viacepModel.uf ?? ""}",
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              Visibility(
                visible: loading,
                child: const CircularProgressIndicator(),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            http
                .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'))
                .then((value) {
              debugPrint(value.toString());
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
