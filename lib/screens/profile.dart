import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/services/auth_service.dart';

import 'package:peneiras/layout/screen_frame.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void _realizarLogout() async {
      final authService = AuthService();
      await authService.logout();

      if (context.mounted) {
        context.go('/login');
      }
    }

    return ScreenFrame(
      title: "",
      onBack: () {},
      showBackButton: false,
      rightWidget: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => print("Configurações clicadas"),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          ElevatedButton(
              onPressed: () {
                _realizarLogout();
                context.go("/login");
              },
              child: const Text("Logout"))
        ],
      ),
    );
  }
}
