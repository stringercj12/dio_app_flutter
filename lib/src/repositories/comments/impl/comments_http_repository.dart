import 'dart:convert';

import 'package:dio_app_flutter/src/model/comment_model.dart';
import 'package:dio_app_flutter/src/repositories/comments/comments_repository.dart';
import 'package:http/http.dart' as http;

class CommentsHttpRepository implements CommentsRepository {
  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async {
    var response = await http.get(Uri.parse(
        'https://jsonplaceholder.typicode.com/posts/$postId/comments'));

    if (response.statusCode == 200) {
      var jsonComments = jsonDecode(response.body);

      return (jsonComments as List)
          .map((json) => CommentModel.fromJson(json))
          .toList();
    }

    return [];
  }
}
