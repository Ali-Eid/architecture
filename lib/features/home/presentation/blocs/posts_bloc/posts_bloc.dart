import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_arch/features/home/domain/usecases/post_usecase.dart';

import '../../../domain/models/posts_model.dart';

part 'posts_event.dart';
part 'posts_state.dart';
part 'posts_bloc.freezed.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostUsecase postUsecase;
  PostsBloc({required this.postUsecase}) : super(const _Initial()) {
    on<PostsEvent>((event, emit) async {
      await event.map(
        getPosts: (value) async {
          emit(const PostsState.loading());
          final failureOrPosts = await postUsecase.execute();
          failureOrPosts.when(
            (posts) {
              emit(PostsState.loaded(posts: posts));
            },
            (error) {
              emit(PostsState.error(message: error.message));
            },
          );
        },
      );
    });
  }
}
