import 'dart:convert';

import 'package:dio_app_flutter/src/model/post_model.dart';
import 'package:dio_app_flutter/src/repositories/posts/post_repository.dart';
import 'package:http/http.dart' as http;

class PostsHttpRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      var jsonPosts = jsonDecode(response.body);

      return (jsonPosts as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
