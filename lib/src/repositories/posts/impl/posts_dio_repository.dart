import 'package:dio_app_flutter/src/model/post_model.dart';
import 'package:dio_app_flutter/src/repositories/jsonplaceholder_custom_dio.dart';
import 'package:dio_app_flutter/src/repositories/posts/post_repository.dart';

class PostsDioRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var jsonPlaceHolderCustomDio = JsonPlaceHolderCustomDio();

    var response = await jsonPlaceHolderCustomDio.dio.get('/posts');

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
