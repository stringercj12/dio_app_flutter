import 'package:dio_app_flutter/src/pages/home_page.dart';
import 'package:flutter/material.dart';

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
      home: const HomePage(),
    );
  }
}
