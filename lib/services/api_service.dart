import 'package:dio/dio.dart';
import 'package:peneiras/models/requests/serializable.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: "http://localhost:8080",
      headers: {
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
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
    Serializable? data,
    Map<String, dynamic>? queryParameters,
    required FromJson<T> fromJson,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data?.toJson(),
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      final responseData = response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : <String, dynamic>{};

      return fromJson(responseData);
    } on DioException catch (e) {
      final String errorMessage =
          e.response?.data?['message'] ?? 'Erro de conexão com o servidor';
      print('Erro de API ($method $path): $errorMessage');
      throw Exception(errorMessage);
    }
  }
}
