import 'package:dio_app_flutter/src/shared/app_images.dart';
import 'package:flutter/material.dart';

class ListViewHorizontal extends StatefulWidget {
  const ListViewHorizontal({super.key});

  @override
  State<ListViewHorizontal> createState() => _ListViewHorizontalState();
}

class _ListViewHorizontalState extends State<ListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Card(
                  elevation: 8,
                  child: Image.asset(
                    AppImages.image1,
                    height: 100,
                  ),
                ),
                Card(
                  elevation: 8,
                  child: Image.asset(
                    AppImages.image2,
                    height: 100,
                  ),
                ),
                Card(
                  elevation: 8,
                  child: Image.asset(
                    AppImages.image3,
                    height: 100,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
