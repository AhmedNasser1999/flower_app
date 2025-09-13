import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../features/auth/domain/services/auth_service.dart';
import '../../contants/api_constants.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio dio(@Named('baseurl') String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        contentType: 'application/json',
      ),
    );

    // Logging
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final requiresAuth = options.extra['auth'] == true;

          if (requiresAuth) {
            final token = await AuthService.getToken();
            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          return handler.next(options);
        },
      ),
    );

    return dio;
  }

  @Named('baseurl')
  String get baseUrl => ApiConstant.baseUrl;
}