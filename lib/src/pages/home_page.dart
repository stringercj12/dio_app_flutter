import 'package:dio_app_flutter/src/pages/calc_imc_page.dart';
import 'package:dio_app_flutter/src/pages/card_page.dart';
import 'package:dio_app_flutter/src/pages/image_assets.dart';
import 'package:dio_app_flutter/src/pages/list_view_horizontal.dart';
import 'package:dio_app_flutter/src/pages/list_view_page.dart';
import 'package:dio_app_flutter/src/pages/tarefa_page.dart';
import 'package:dio_app_flutter/src/shared/widgets/custom_drawer.dart';
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
      drawer: const CustomDrawer(),
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
                CardPage(),
                ImageAssetsPage(),
                ListViewPage(),
                ListViewHorizontal(),
                TarefaPage(),
                CalcImcPage()
              ],
            ),
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              pageController.jumpToPage(value);
            },
            currentIndex: posicaoPagina,
            items: const [
              BottomNavigationBarItem(
                label: 'Cards',
                icon: Icon(Icons.card_travel_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Images',
                icon: Icon(Icons.image),
              ),
              BottomNavigationBarItem(
                label: 'List View',
                icon: Icon(Icons.list_alt),
              ),
              BottomNavigationBarItem(
                label: 'List H',
                icon: Icon(Icons.list_sharp),
              ),
              BottomNavigationBarItem(
                label: 'Tarefas',
                icon: Icon(Icons.list),
              ),
              BottomNavigationBarItem(
                label: 'IMC',
                icon: Icon(Icons.calculate),
              ),
            ],
          )
        ],
      ),
    );
  }
}
