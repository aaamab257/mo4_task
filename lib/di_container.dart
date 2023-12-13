import 'package:dio/dio.dart';
import 'package:mo4_task_posts_app/constant.dart';
import 'package:mo4_task_posts_app/data/remote/dio/dio_client.dart';
import 'package:get_it/get_it.dart';
import 'package:mo4_task_posts_app/data/remote/dio/logging_interceptor.dart';
import 'package:mo4_task_posts_app/providers/posts_providers.dart';
import 'package:mo4_task_posts_app/repo/post_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(
      () => DioClient(AppConstant.baseUrl, sl(), loggingInterceptor: sl()));

  sl.registerLazySingleton(
      () => PostRepo(dioClient: sl(), sharedPreferences: sl()));

  sl.registerFactory(() => PostProvider(postRepo: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
