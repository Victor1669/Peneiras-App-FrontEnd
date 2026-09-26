import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peneiras/utils/preferences_helper.dart';

class IsClubeController extends Notifier<bool> {
  @override
  bool build() {
    return _loadIsClube();
  }

  bool _loadIsClube() {
    return PreferencesHelper.getBool('is_clube') ?? false;
  }

  void reload() {
    state = _loadIsClube();
  }
}

final isClubeProvider = NotifierProvider<IsClubeController, bool>(
  IsClubeController.new,
);
