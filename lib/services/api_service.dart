import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: "http://localhost:8080",
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final prefs = await SharedPreferences.getInstance();
            final String? token = prefs.getString('auth_token');

            if (token != null && token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          } catch (e) {
            print('Erro ao recuperar token de autenticação: $e');
          }

          return handler.next(options);
        },
      ),
    );
  }

  Future<T> request<T>({
    required String path,
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) fromJson,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      return fromJson(response.data);
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data?['message'] ?? 'Erro de conexão com o servidor';
      print('Erro de API ($method $path): $errorMessage');
      throw Exception(errorMessage);
    }
  }
}
