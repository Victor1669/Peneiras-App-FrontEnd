import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:peneiras/utils/preferences_helper.dart';

class IsClubeController extends Notifier<bool> {
  @override
  bool build() {
    return _loadIsClube();
  }

  bool _loadIsClube() {
    final token = PreferencesHelper.getString("access_token");

    if (token == null || token.isEmpty) {
      return false;
    }

    try {
      final payload = JwtDecoder.decode(token);
      return payload['isClube'] as bool;
    } catch (_) {
      return false;
    }
  }

  void reload() {
    state = _loadIsClube();
  }
}

final isClubeProvider = NotifierProvider<IsClubeController, bool>(
  IsClubeController.new,
);
