import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/services/auth_service.dart';
import 'package:peneiras/layout/screen_frame.dart';
import 'package:peneiras/constants/app_colors.dart';

import 'club_profile.dart';
import 'player_profile.dart';

class ProfileScreen extends StatelessWidget {
  final bool isClub;

  const ProfileScreen({super.key, this.isClub = false});

  @override
  Widget build(BuildContext context) {
    void realizarLogout() async {
      final authService = AuthService();
      await authService.logout();

      if (context.mounted) {
        context.go('/login');
      }
    }

    return ScreenFrame(
      title: isClub ? "Perfil de Clube" : "Perfil do Jogador",
      onBack: () {},
      showBackButton: false,
      rightWidget: IconButton(
        icon: const Icon(Icons.settings, color: AppColors.lightGreen),
        onPressed: () => print("Configurações clicadas"),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            isClub ? const ClubProfile() : const PlayerProfile(),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: realizarLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Logout"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
