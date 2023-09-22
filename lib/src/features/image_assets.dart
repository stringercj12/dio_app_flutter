import 'package:dio_app_flutter/src/shared/app_images.dart';
import 'package:flutter/material.dart';

class ImageAssetsPage extends StatefulWidget {
  const ImageAssetsPage({super.key});

  @override
  State<ImageAssetsPage> createState() => _ImageAssetsPageState();
}

class _ImageAssetsPageState extends State<ImageAssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.user,
          height: 50,
        ),
        Image.asset(
          AppImages.car,
          height: 50,
        ),
        Image.asset(
          AppImages.car2,
          height: 50,
        ),
        Image.asset(
          AppImages.image1,
          height: 50,
        ),
        Image.asset(
          AppImages.image2,
          height: 50,
        ),
        Image.asset(
          AppImages.image3,
          width: double.infinity,
        ),
      ],
    );
  }
}
