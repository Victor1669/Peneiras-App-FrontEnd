import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/models/requests/clube_requests.dart';
import 'package:peneiras/services/api_service.dart';

class ClubService {
  final ApiService apiService = ApiService();

  Future<UserResponse> create(CreateClubRequest body) async {
    return apiService.request<UserResponse>(
      path: "/api/auth/clube/register",
      data: body,
      method: "POST",
      fromJson: (json) => UserResponse.fromJson(json),
    );
  }

  Future<void> edit({
    required UpdateClubRequest dto,
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
      path: '/clubes/me',
      method: 'PUT',
      files: files,
      fromJson: (json) => UserResponse.fromJson(json),
      showErrorSnackBar: true,
    );
  }
}
