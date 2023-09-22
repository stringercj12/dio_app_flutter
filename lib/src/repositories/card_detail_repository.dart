import 'package:dio_app_flutter/src/model/card_detail.dart';

class CardDetailRepository {
  Future<CardDetail> get() async {
    await Future.delayed(const Duration(seconds: 3));
    return CardDetail(
      1,
      "Meu Card",
      "https://hermes.digitalinnovation.one/assets/diome/logo.png",
      "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable.",
    );
  }
}
