import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peneiras/utils/secure_store_helper.dart';

final authStateProvider = FutureProvider<bool>((ref) async {
  final refreshToken = await SecureStorageHelper.getString('refresh_token');

  return refreshToken != null && refreshToken.isNotEmpty;
});
