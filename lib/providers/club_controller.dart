import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:peneiras/models/requests/clube_requests.dart';
import 'package:peneiras/services/club_service.dart';

final clubControllerProvider = AsyncNotifierProvider<ClubController, dynamic>(
  ClubController.new,
);

class ClubController extends AsyncNotifier<dynamic> {
  @override
  Future<dynamic> build() async {
    return await ClubService().getClub();
  }

  Future<void> updateClub({
    required ClubWithAddressRequest dto,
    File? photo,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ClubService().edit(dto: dto, photo: photo);
      return await ClubService().getClub();
    });
  }
}
