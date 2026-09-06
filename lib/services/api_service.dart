import 'package:dio/dio.dart';
import 'package:peneiras/models/requests/serializable.dart';
import 'package:peneiras/utils/snackbar_helper.dart';
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

  String _extractErrorMessage(DioException e) {
    final data = e.response?.data;

    if (data == null) return 'Erro de conexão com o servidor';

    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ?? 'Erro desconhecido';
    }

    if (data is String) {
      return data;
    }

    return 'Erro desconhecido';
  }

  Future<T> request<T>({
    required String path,
    required String method,
    Serializable? data,
    Map<String, dynamic>? queryParameters,
    required FromJson<T> fromJson,
    bool showErrorSnackBar = false,
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
      final errorMessage = _extractErrorMessage(e);
      print('Erro de API ($method $path): $errorMessage');

      if (showErrorSnackBar) {
        showAppSnackBar(errorMessage, isError: true);
      }

      throw Exception(errorMessage);
    }
  }

  Future<T> requestMultipart<T>({
    required String path,
    required String method,
    Map<String, dynamic>? fields,
    Map<String, MultipartFile>? files,
    Map<String, dynamic>? queryParameters,
    required FromJson<T> fromJson,
    bool showErrorSnackBar = false,
  }) async {
    try {
      final formData = FormData();

      if (fields != null) {
        fields.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });
      }

      if (files != null) {
        files.forEach((key, file) {
          formData.files.add(MapEntry(key, file));
        });
      }

      final response = await _dio.request(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          contentType: 'multipart/form-data',
        ),
      );

      final responseData = response.data is Map<String, dynamic>
          ? response.data as Map<String, dynamic>
          : <String, dynamic>{};

      return fromJson(responseData);
    } on DioException catch (e) {
      final errorMessage = _extractErrorMessage(e);
      print('Erro de API ($method $path): $errorMessage');

      if (showErrorSnackBar) {
        showAppSnackBar(errorMessage);
      }

      throw Exception(errorMessage);
    }
  }
}
