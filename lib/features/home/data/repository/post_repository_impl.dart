import 'package:dio/dio.dart';
import 'package:multiple_result/src/result.dart';

import 'package:new_arch/core/bases/models/failure_model/failure_model.dart';
import 'package:new_arch/core/network/network_info.dart';
import 'package:new_arch/features/home/data/datasource/remote_data_source/home_api.dart';

import 'package:new_arch/features/home/domain/models/posts_model.dart';

import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final HomeServiceClient homeServiceClient;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.homeServiceClient, required this.networkInfo});
  @override
  Future<Result<List<PostModel>, FailureModel>> getPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await homeServiceClient.getPosts();
        if (response.response.statusCode == 200) {
          return Success(response.data);
        } else {
          return Error(FailureModel.fromJson(response.response.data));
        }
      } on DioException catch (e) {
        return Error(FailureModel.fromJson(e.response?.data ?? defaultError));
      }
    } else {
      return Error(FailureModel(message: "noInternetError"));
    }
  }
}
