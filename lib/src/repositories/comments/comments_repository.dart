import 'package:dio_app_flutter/src/model/comment_model.dart';

abstract class CommentsRepository {
  Future<List<CommentModel>> retornaComentarios(int postId);
}
