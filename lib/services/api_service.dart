import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:peneiras/utils/global_keys.dart';
import 'package:peneiras/utils/secure_store_helper.dart';

typedef FromJson<T> = T Function(Map<String, dynamic> json);

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: dotenv.env['BACKEND_URL'] ?? "",
      headers: {
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? accessToken =
              await SecureStorageHelper.getString('access_token');

          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          final showSuccess =
              response.requestOptions.extra['showSuccessSnackBar'] ?? true;

          if (showSuccess) {
            try {
              final data = response.data;
              String? message;

              if (data is Map && data.containsKey('message')) {
                message = data['message']?.toString();
              } else if (data is String && data.trim().isNotEmpty) {
                message = data;
              }

              if (message != null && message.isNotEmpty) {
                rootScaffoldMessengerKey.currentState?.showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            } catch (_) {}
          }

          return handler.next(response);
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
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) fromJson,
    bool showErrorSnackBar = false,
    bool showSuccessSnackBar = true,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data?.toJson(),
        queryParameters: queryParameters,
        options: Options(
          method: method,
          extra: {'showSuccessSnackBar': showSuccessSnackBar},
        ),
      );

      return fromJson(response.data);
    } on DioException catch (e) {
      final errorMessage = _extractErrorMessage(e);
      print('Erro de API ($method $path): $errorMessage');

      if (showErrorSnackBar) {
        showAppSnackBar(errorMessage);
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
    bool showSuccessSnackBar = true,
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
          extra: {'showSuccessSnackBar': showSuccessSnackBar},
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

void showAppSnackBar(String message, {bool isError = true}) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.redAccent : Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
