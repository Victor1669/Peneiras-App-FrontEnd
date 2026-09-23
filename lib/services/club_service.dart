import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:peneiras/models/requests/clube_requests.dart';
import 'package:peneiras/services/api_service.dart';

class ClubService {
  final ApiService apiService = ApiService();

  Future<ClubWithAddressRequest> getClub() async {
    return await apiService.request<ClubWithAddressRequest>(
        path: "/clubes/me",
        method: "GET",
        fromJson: (json) => ClubWithAddressRequest.fromJson(json));
  }

  Future<void> create(CreateClubRequest body) async {
    return await apiService.request(
      path: "/clubes/register",
      data: body,
      method: "POST",
      fromJson: (json) => {},
    );
  }

  Future<void> edit({
    required ClubWithAddressRequest dto,
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

    await apiService.requestMultipart(
      path: '/clubes/me',
      method: 'PUT',
      files: files,
      fromJson: (json) => {},
      showErrorSnackBar: true,
    );
  }
}
