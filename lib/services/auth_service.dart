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
        fromJson: (json) => LoginResponse.fromJson(json),
        showErrorSnackBar: true);

    await PreferencesHelper.saveString('auth_token', response.token);
    return response;
  }

  Future<bool> logout() async {
    return await PreferencesHelper.remove('auth_token');
  }
}
