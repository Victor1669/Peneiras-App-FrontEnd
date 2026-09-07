import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';
import 'package:peneiras/utils/global_keys.dart';

import 'package:peneiras/widgets/perfil/perfil_infos.dart';
import 'package:peneiras/widgets/perfil/perfil_ui.dart';

class PlayerProfile extends StatefulWidget {
  final bool isFake;

  const PlayerProfile({super.key, this.isFake = true});

  @override
  State<PlayerProfile> createState() => _PlayerProfileState();
}

class _PlayerProfileState extends State<PlayerProfile> {
  late bool isLoading;

  late String image;
  late String name;
  late String position;
  late String birthDate;
  late String number;
  late String aboutText;

  @override
  void initState() {
    super.initState();

    isLoading = !widget.isFake;

    if (widget.isFake) {
      _loadMockData();
    } else {
      image = "";
      name = "";
      position = "";
      birthDate = "";
      number = "";
      aboutText = "";
      _fetchPlayerData();
    }
  }

  void _loadMockData() {
    image = "assets/logo.png";
    name = "User";
    position = "Meia Atacante";
    birthDate = "24/03/2009";
    number = "10";
    aboutText =
        "Jogador dedicado, com boa visão de jogo, passe preciso e chegada forte ao ataque. Buscando sempre evoluir e ajudar a equipe dentro e fora de campo.";
  }

  Future<void> _fetchPlayerData() async {
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    setState(() {
      _loadMockData();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.lightGreen),
      );
    }

    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGreen, width: 2),
          ),
          child: ClipOval(
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: GoogleFonts.judson(
            fontSize: 26,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 15, color: AppColors.lightGreen),
            const SizedBox(width: 4),
            Text(position,
                style: const TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(width: 8),
            const PerfilDivider(height: 12),
            const SizedBox(width: 8),
            const Icon(Icons.calendar_today,
                size: 13, color: AppColors.lightGreen),
            const SizedBox(width: 4),
            Text(birthDate,
                style: const TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.darkBlue2,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lightGreen),
          ),
          child: Row(
            key: perfilPlayerInfoKey,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PerfilInfo(
                  icon: Icons.sports_soccer, title: "Posição", value: position),
              const PerfilDivider(height: 36),
              PerfilInfo(
                  icon: Icons.calendar_month,
                  title: "Nascimento",
                  value: birthDate),
              const PerfilDivider(height: 36),
              PerfilInfo(icon: Icons.shield, title: "Número", value: number),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon:
                const Icon(Icons.person, color: AppColors.lightGreen, size: 20),
            label: Text(
              "Ver Peneiras",
              style: GoogleFonts.judson(
                fontSize: 15,
                color: AppColors.lightGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.lightGreen),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              padding: const EdgeInsets.symmetric(vertical: 18),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.lightGreen, size: 18),
              SizedBox(width: 6),
              Text(
                "Sobre",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.darkBlue2,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.lightGreen),
          ),
          child: Text(
            aboutText,
            style: const TextStyle(
                color: Colors.white70, fontSize: 14, height: 1.4),
          ),
        ),
      ],
    );
  }
}
