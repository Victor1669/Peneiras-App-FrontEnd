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
  Future<PlayerWithAddressRequest> build() async {
    final player = await PlayerService().getPlayer();

    print(player.toJson());

    return player;
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
