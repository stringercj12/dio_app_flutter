import 'package:dio_app_flutter/my_app.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key, required this.onPageChanged});

  final Function(Widget) onPageChanged;

  List<ListItems> drawerItens = [
    ListItems(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      page: HomePage(),
    ),
    ListItems(
      icon: const Icon(Icons.home),
      title: const Text('Reserva'),
      page: HomePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Theme(
        data: ThemeData.dark(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: drawerItens
              .map((e) => ListTile(
                    title: e.title,
                    leading: e.icon,
                    onTap: () {
                      onPageChanged(e.page);
                    },
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class ListItems {
  final Icon icon;
  final Text title;
  final Widget page;

  ListItems({
    required this.icon,
    required this.title,
    required this.page,
  });
}
