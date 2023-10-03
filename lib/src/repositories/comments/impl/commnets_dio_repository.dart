import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_app_flutter/src/model/comment_model.dart';
import 'package:dio_app_flutter/src/repositories/comments/comments_repository.dart';
import 'package:dio_app_flutter/src/repositories/jsonplaceholder_custom_dio.dart';

class CommentsDioRepository implements CommentsRepository {
  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async {
    var jsonPlaceHolderCustomDio = JsonPlaceHolderCustomDio();

    var response =
        await jsonPlaceHolderCustomDio.dio.get('/posts/$postId/comments');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((json) => CommentModel.fromJson(json))
          .toList();
    }

    return [];
  }
}
