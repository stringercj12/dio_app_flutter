import 'package:dio_app_flutter/src/shared/widgets/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ZoomDrawerController z = ZoomDrawerController();
  Widget page = HomePage();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      home: ZoomDrawer(
        menuScreen: Builder(
          builder: (context) {
            return MenuScreen(
              onPageChanged: (e) {
                setState(() {
                  page = e;
                });
                ZoomDrawer.of(context)!.close();
              },
            );
          },
        ),
        mainScreen: page,
        borderRadius: 24.8,
        menuBackgroundColor: Colors.indigo,
        showShadow: true,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My app - menu home'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)!.toggle();
            debugPrint('Menu my app');
          },
        ),
      ),
    );
  }
}
