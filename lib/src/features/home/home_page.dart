import 'package:dio_app_flutter/src/features/card_page.dart';
import 'package:dio_app_flutter/src/features/image_assets.dart';
import 'package:dio_app_flutter/src/features/list_view_h.dart';
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
                ListViewHPage(),
              ],
            ),
          ),
          BottomNavigationBar(
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
                label: 'List',
                icon: Icon(Icons.list),
              ),
            ],
          )
        ],
      ),
    );
  }
}
