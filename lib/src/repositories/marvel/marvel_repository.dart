import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:convert/convert.dart' as convert;
import 'package:dio_app_flutter/src/model/marvel/characters_model.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite/utils/utils.dart';

class MarvelRepository {
  Future<CharactersModel> getCharacters(int offset) async {
    var dio = Dio();
    var ts = DateTime.now().microsecondsSinceEpoch.toString();
    var publicKey = dotenv.get('MARVEL_PUBLIC_KEY');
    var privateKey = dotenv.get('MARVEL_API_KEY');
    var hash = _generateMD5(ts + privateKey + publicKey);
    var query = "offset=$offset&ts=$ts&apikey=$publicKey&hash=$hash";
    var url = 'http://gateway.marvel.com/v1/public/characters?$query';
    print(url.toString());
    var response = await dio.get(url);

    var charactersModel = CharactersModel.fromJson(response.data);

    return charactersModel;
  }

  _generateMD5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return convert.hex.encode(digest.bytes);
  }
}
