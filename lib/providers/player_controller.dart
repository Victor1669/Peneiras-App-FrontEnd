import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peneiras/models/requests/player_requests.dart';
import 'package:peneiras/services/player_service.dart';

final playerControllerProvider =
    AsyncNotifierProvider<PlayerController, dynamic>(
  PlayerController.new,
);

class PlayerController extends AsyncNotifier<dynamic> {
  @override
  Future<dynamic> build() async {
    try {
      final player = await PlayerService().getPlayer();
      return player;
    } catch (_) {
      return null;
    }
  }

  Future<void> updatePlayer({
    required PlayerWithAddressRequest dto,
    File? photo,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await PlayerService().edit(dto: dto, photo: photo);
      return await PlayerService().getPlayer();
    });
  }
}
