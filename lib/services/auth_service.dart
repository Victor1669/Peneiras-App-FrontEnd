import 'package:peneiras/models/requests/auth_requests.dart';
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
        fromJson: (json) => LoginResponse.fromJson(json),
        showErrorSnackBar: true);

    await PreferencesHelper.saveString('access_token', response.accessToken);
    await PreferencesHelper.saveString('refresh_token', response.refreshToken);

    return response;
  }

  Future<void> logout() async {
    await PreferencesHelper.remove('access_token');
    await PreferencesHelper.remove('refresh_token');
  }

  Future<void> refreshtoken(RefreshTokenRequest body) async {
    final response = await _apiService.request<RefreshTokenResponse>(
        path: "/auth/refresh",
        method: "POST",
        data: body,
        showSuccessSnackBar: false,
        showErrorSnackBar: true,
        fromJson: (json) => RefreshTokenResponse.fromJson(json));

    await PreferencesHelper.saveString('access_token', response.accessToken);
    await PreferencesHelper.saveString('refresh_token', response.refreshToken);
  }
}
