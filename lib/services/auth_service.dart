import 'package:peneiras/models/bodys/cadastro_body.dart';
import 'package:peneiras/services/api_service.dart';
import 'package:peneiras/utils/preferences_helper.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future createPlayer(CadastroPlayerBody body) {
    final response = _apiService.request(
        path: "/auth/register",
        data: body,
        method: "POST",
        fromJson: (json) => CadastroResponse.fromJson(json));

    return response;
  }

  Future createClub(CadastroClubBody body) {
    final response = _apiService.request(
        path: "/api/auth/clube/register",
        data: body,
        method: "POST",
        fromJson: (json) => CadastroResponse.fromJson(json));

    return response;
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.request<LoginResponse>(
      path: '/auth/login',
      method: 'POST',
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );

    await PreferencesHelper.saveString('auth_token', response.token);

    return response;
  }

  Future<bool> logout() async {
    return await PreferencesHelper.remove('auth_token');
  }
}

class CadastroResponse {
  CadastroResponse();

  factory CadastroResponse.fromJson(Map<String, dynamic> json) {
    return CadastroResponse();
  }
}

class LoginResponse {
  final String message;
  final String token;

  LoginResponse({
    required this.message,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
