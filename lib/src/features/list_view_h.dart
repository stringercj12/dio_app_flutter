import 'package:dio_app_flutter/src/shared/app_images.dart';
import 'package:flutter/material.dart';

class ListViewHPage extends StatefulWidget {
  const ListViewHPage({super.key});

  @override
  State<ListViewHPage> createState() => _ListViewHPageState();
}

class _ListViewHPageState extends State<ListViewHPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(
            AppImages.user,
          ),
          title: const Text('Usuário'),
          subtitle: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Olá! Tudo bem?'),
              Text('08:59'),
            ],
          ),
          trailing: PopupMenuButton<String>(
            onSelected: (menu) {
              debugPrint(menu);
            },
            itemBuilder: (BuildContext buildContext) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem(value: "opcao1", child: Text('Opção 1')),
                const PopupMenuItem(value: "opcao2", child: Text('Opção 2')),
                const PopupMenuItem(value: "opcao3", child: Text('Opção 3')),
              ];
            },
          ),
          // isThreeLine: true,
        ),
        Image.asset(
          AppImages.car,
          width: double.infinity,
        ),
        Image.asset(
          AppImages.car2,
          width: double.infinity,
        ),
        Image.asset(
          AppImages.image1,
          width: double.infinity,
        ),
        Image.asset(
          AppImages.image2,
          width: double.infinity,
        ),
        Image.asset(
          AppImages.image3,
          width: double.infinity,
        ),
      ],
    );
  }
}
