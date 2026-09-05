import 'package:peneiras/models/requests/cadastro_requests.dart';
import 'package:peneiras/models/requests/login_requests.dart';
import 'package:peneiras/services/api_service.dart';
import 'package:peneiras/utils/preferences_helper.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<CreateUsersResponse> createPlayer(CreatePlayerRequest body) {
    return _apiService.request<CreateUsersResponse>(
      path: "/auth/register",
      method: "POST",
      data: body,
      fromJson: CreateUsersResponse.fromJson,
    );
  }

  Future<CreateUsersResponse> createClub(CreateClubRequest body) async {
    return _apiService.request<CreateUsersResponse>(
      path: "/api/auth/clube/register",
      data: body,
      method: "POST",
      fromJson: (json) => CreateUsersResponse.fromJson(json),
    );
  }

  Future<LoginResponse> login(LoginRequest body) async {
    final response = await _apiService.request<LoginResponse>(
      path: "/auth/login",
      method: "POST",
      data: body,
      fromJson: LoginResponse.fromJson,
    );

    await PreferencesHelper.saveString('auth_token', response.token);
    return response;
  }

  Future<bool> logout() async {
    return await PreferencesHelper.remove('auth_token');
  }
}
