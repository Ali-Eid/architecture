import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:new_arch/features/home/data/datasource/remote_data_source/home_api.dart';
import 'package:new_arch/features/home/data/repository/post_repository_impl.dart';
import 'package:new_arch/features/home/domain/repositories/post_repository.dart';
import 'package:new_arch/features/home/domain/usecases/post_usecase.dart';
import 'package:new_arch/features/home/presentation/blocs/posts_bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../cache/app_preferences.dart';
import '../network/dio_factory.dart';
import '../network/general_dio_interceptor.dart';
import '../network/network_info.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  instance.registerFactory<SharedPreferences>(() => sharedPreferences);
  instance.registerFactory<AppPreferences>(() => AppPreferences(instance()));
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));
  instance.registerFactory<GeneralInterceptor>(() => GeneralInterceptor(
        instance(),
      ));
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImplementer(Connectivity()));

  //Service Client
  instance.registerLazySingleton(() => HomeServiceClient(dio));
}

Future<void> initPosts() async {
  //blocs
  instance
      .registerFactory(() => PostsBloc(postUsecase: instance<PostUsecase>()));

  //repositories
  instance.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      homeServiceClient: instance<HomeServiceClient>(),
      networkInfo: instance<NetworkInfo>()));

  //usecases
  instance.registerLazySingleton(
      () => PostUsecase(postRepository: instance<PostRepository>()));
}
