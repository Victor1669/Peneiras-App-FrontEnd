import 'package:peneiras/models/requests/serializable.dart';

class LoginRequest implements Serializable {
  final String email;
  final String password;

  const LoginRequest({
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final String message;
  final String accessToken;
  final String refreshToken;

  const LoginResponse(
      {required this.message,
      required this.accessToken,
      required this.refreshToken});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        message: json['message'] ?? '',
        accessToken: json['token'] ?? '',
        refreshToken: json["refreshToken"] ?? '');
  }
}

class RefreshTokenRequest implements Serializable {
  final String refreshToken;

  const RefreshTokenRequest({required this.refreshToken});

  @override
  Map<String, dynamic> toJson() {
    return {
      'refreshToken': refreshToken,
    };
  }
}

class RefreshTokenResponse extends RefreshTokenRequest {
  final String accessToken;

  const RefreshTokenResponse(
      {required super.refreshToken, required this.accessToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(
        accessToken: json["accessToken"] ?? "",
        refreshToken: json["refreshToken"] ?? "");
  }
}
