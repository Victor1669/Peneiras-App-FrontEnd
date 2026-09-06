import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/models/requests/login_requests.dart';
import 'package:peneiras/services/api_service.dart';
import 'package:peneiras/utils/preferences_helper.dart';

enum PhotoType { player, club }

class AuthService {
  final ApiService _apiService = ApiService();

  Future<LoginResponse> login(LoginRequest body) async {
    final response = await _apiService.request<LoginResponse>(
        path: "/auth/login",
        method: "POST",
        data: body,
        fromJson: LoginResponse.fromJson,
        showErrorSnackBar: true);

    await PreferencesHelper.saveString('auth_token', response.token);
    return response;
  }

  Future<bool> logout() async {
    return await PreferencesHelper.remove('auth_token');
  }

  Future<UploadPhotoResponse> uploadPhoto({
    required PhotoType type,
    File? file,
    Uint8List? bytes,
  }) async {
    MultipartFile multipartFile;

    if (kIsWeb) {
      if (bytes == null) throw Exception('Nenhuma imagem selecionada');
      multipartFile = MultipartFile.fromBytes(
        bytes,
        filename: 'profile_photo.jpg',
      );
    } else {
      if (file == null) throw Exception('Nenhuma imagem selecionada');
      multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: 'profile_photo.jpg',
      );
    }

    final String path =
        type == PhotoType.player ? "/player/me/photo" : "/club/me/photo";

    return _apiService.requestMultipart<UploadPhotoResponse>(
      path: path,
      method: "POST",
      files: {
        'photo': multipartFile,
      },
      fromJson: UploadPhotoResponse.fromJson,
    );
  }
}
