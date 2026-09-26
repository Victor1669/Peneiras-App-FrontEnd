import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peneiras/models/requests/auth_requests.dart';
import 'package:peneiras/utils/secure_store_helper.dart';
import 'package:peneiras/services/auth_service.dart';

final authStateProvider = FutureProvider<bool>((ref) async {
  try {
    final refreshToken = await SecureStorageHelper.getString('refresh_token');

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    final authService = ref.read(authServiceProvider);

    await authService.refreshtoken(
      RefreshTokenRequest(refreshToken: refreshToken),
    );

    return true;
  } catch (e) {
    print('Erro ao fazer refresh token: $e');
    return false;
  }
});

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});
