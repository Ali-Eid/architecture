import 'package:multiple_result/multiple_result.dart';
import 'package:new_arch/features/home/domain/models/posts_model.dart';

import '../../../../core/bases/models/failure_model/failure_model.dart';

abstract class PostRepository {
  Future<Result<List<PostModel>, FailureModel>> getPosts();
}
