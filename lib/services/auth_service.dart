import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:peneiras/models/requests/auth_requests.dart';
import 'package:peneiras/services/api_service.dart';
import 'package:peneiras/utils/preferences_helper.dart';
import 'package:peneiras/utils/secure_store_helper.dart';

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

    await SecureStorageHelper.setString('access_token', response.accessToken);
    await SecureStorageHelper.setString('refresh_token', response.refreshToken);

    final payload = JwtDecoder.decode(response.accessToken);
    final isClube = payload['isClube'] as bool? ?? false;
    await PreferencesHelper.saveBool('is_clube', isClube);

    return response;
  }

  Future<void> logout() async {
    await SecureStorageHelper.remove('access_token');
    await SecureStorageHelper.remove('refresh_token');
    await PreferencesHelper.remove('is_clube');
  }

  Future<void> refreshtoken(RefreshTokenRequest body) async {
    final response = await _apiService.request<RefreshTokenResponse>(
        path: "/auth/refresh",
        method: "POST",
        data: body,
        showSuccessSnackBar: false,
        showErrorSnackBar: true,
        fromJson: (json) => RefreshTokenResponse.fromJson(json));

    await SecureStorageHelper.setString('access_token', response.accessToken);
    await SecureStorageHelper.setString('refresh_token', response.refreshToken);

    final payload = JwtDecoder.decode(response.accessToken);
    final isClube = payload['isClube'] as bool? ?? false;
    await PreferencesHelper.saveBool('is_clube', isClube);
  }
}
