import 'package:dio_app_flutter/src/model/post_model.dart';

abstract class PostsRepository {
  Future<List<PostModel>> getPosts();
}
