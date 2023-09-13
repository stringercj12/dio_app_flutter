import 'package:dio_app_flutter/src/features/dados_cadastrais/dados_cadastrais_page.dart';
import 'package:dio_app_flutter/src/features/login/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dio App Fluter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // textTheme: Google,
        useMaterial3: true,
      ),
      home: const DadosCadastraisPage(),
    );
  }
}
