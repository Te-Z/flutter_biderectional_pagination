import 'package:dio/dio.dart';
import 'package:flutter_biderectional_pagination/config/app_const.dart';
import 'package:flutter_biderectional_pagination/data/network/character.api.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class DiInitializer {
  static final DiInitializer _singleton = DiInitializer._internal();

  factory DiInitializer() {
    return _singleton;
  }

  DiInitializer._internal();

  void setUp() {
    GetIt.I.registerLazySingleton<Dio>(() {
      final options = BaseOptions(
        baseUrl: AppConst.baseApiUrl,
        connectTimeout: AppConst.connectTimeout,
      );
      final dio = Dio();

      dio.interceptors.addAll([
        LogInterceptor(
          responseBody: true,
          requestBody: true,
        )
      ]);

      dio.options = options;
      return dio;
    });

    GetIt.I.registerLazySingleton<CharacterApi>(() => CharacterApi());
  }
}
