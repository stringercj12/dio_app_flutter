import 'package:dio_app_flutter/src/features/dados_cadastrais/dados_cadastrais_page.dart';
import 'package:dio_app_flutter/src/features/pagina1.dart';
import 'package:dio_app_flutter/src/features/pagina2.dart';
import 'package:dio_app_flutter/src/features/pagina3.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);
  int posicaoPagina = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu app')),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: const Text('Dados Cadastrais'),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DadosCadastraisPage(),
                    ),
                  );
                },
              ),
              const Divider(),
              const SizedBox(height: 30),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: const Text('Termos de uso e privacidade'),
                ),
                onTap: () {},
              ),
              const Divider(),
              const SizedBox(height: 30),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: const Text('Configurações'),
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  posicaoPagina = value;
                });
              },
              children: const [
                Pagina1Page(),
                Pagina2Page(),
                Pagina3Page(),
              ],
            ),
          ),
          BottomNavigationBar(
            onTap: (value) {
              pageController.jumpToPage(value);
            },
            currentIndex: posicaoPagina,
            items: const [
              BottomNavigationBarItem(label: 'Pag1', icon: Icon(Icons.home)),
              BottomNavigationBarItem(label: 'Pag2', icon: Icon(Icons.add)),
              BottomNavigationBarItem(label: 'Pag3', icon: Icon(Icons.person)),
            ],
          )
        ],
      ),
    );
  }
}
