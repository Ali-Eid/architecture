import 'package:multiple_result/src/result.dart';
import 'package:new_arch/core/bases/models/failure_model/failure_model.dart';
import 'package:new_arch/core/bases/usecases/base_usecase.dart';
import 'package:new_arch/features/home/domain/models/posts_model.dart';
import 'package:new_arch/features/home/domain/repositories/post_repository.dart';

class PostUsecase extends BaseUseCaseEmptyInput<List<PostModel>> {
  final PostRepository postRepository;

  PostUsecase({required this.postRepository});
  @override
  Future<Result<List<PostModel>, FailureModel>> execute() async {
    return await postRepository.getPosts();
  }
}
