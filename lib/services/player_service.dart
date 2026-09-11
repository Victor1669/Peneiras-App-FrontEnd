import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:peneiras/services/api_service.dart';

import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/models/requests/player_requests.dart';

class PlayerService {
  final ApiService apiService = ApiService();

  Future<UserResponse> create(CreatePlayerRequest body) {
    return apiService.request<UserResponse>(
        path: "/auth/register",
        method: "POST",
        data: body,
        fromJson: (json) => UserResponse.fromJson(json),
        showErrorSnackBar: true);
  }

  Future<void> edit({
    required UpdatePlayerRequest dto,
    File? photo,
  }) async {
    final files = <String, MultipartFile>{
      'data': MultipartFile.fromString(
        jsonEncode(dto.toJson()),
        contentType: DioMediaType('application', 'json'),
      ),
    };

    if (photo != null) {
      files['photo'] = await MultipartFile.fromFile(
        photo.path,
        filename: photo.path.split('/').last,
      );
    }

    await apiService.requestMultipart<UserResponse>(
      path: '/players/me',
      method: 'PUT',
      files: files,
      fromJson: (json) => UserResponse.fromJson(json),
      showErrorSnackBar: true,
    );
  }
}
