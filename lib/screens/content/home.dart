import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:peneiras/layout/home/home_header.dart';
import 'package:peneiras/layout/home/home_destaques.dart';
import 'package:peneiras/layout/home/home_peneiras.dart';
import 'package:peneiras/layout/screen_frame.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _carregarEPrintarToken();
  }

  Future<void> _carregarEPrintarToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    print("[DEBUG] Auth Token carregado na Home: $token");

    if (token != null && mounted) {}
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      title: "",
      onBack: () {},
      showBackButton: false,
      rightWidget: IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () => print("Notificações clicadas"),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HomeDestaques(),
                  const HomePeneiras(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
