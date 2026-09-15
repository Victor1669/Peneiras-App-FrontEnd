import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:peneiras/services/api_service.dart';

import 'package:peneiras/models/requests/player_requests.dart';

class PlayerService {
  final ApiService apiService = ApiService();

  Future<PlayerWithAddressRequest> getPlayer() async {
    return await apiService.request<PlayerWithAddressRequest>(
        path: "/players/me",
        method: "GET",
        fromJson: (json) => PlayerWithAddressRequest.fromJson(json));
  }

  Future<void> create(CreatePlayerRequest body) {
    return apiService.request(
        path: "/players/register",
        method: "POST",
        data: body,
        fromJson: (json) => {},
        showErrorSnackBar: true);
  }

  Future<void> edit({
    required PlayerWithAddressRequest dto,
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
      path: '/players/me',
      method: 'PUT',
      files: files,
      fromJson: (json) => {},
      showErrorSnackBar: true,
    );
  }
}
