import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';

class PlayerProfile extends StatelessWidget {
  const PlayerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.lightGreen,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              "assets/logo.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          "User",
          style: GoogleFonts.judson(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 16, color: AppColors.lightGreen),
            SizedBox(width: 6),
            Text("Meia Atacante",
                style: TextStyle(color: Colors.white70, fontSize: 14)),
            SizedBox(width: 10),
            _ProfileDivider(height: 14),
            SizedBox(width: 10),
            Icon(Icons.calendar_today, size: 14, color: AppColors.lightGreen),
            SizedBox(width: 6),
            Text("24/03/2009",
                style: TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.darkBlue2,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.lightGreen,
              width: 1.5,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ProfileInfoColumn(
                icon: Icons.sports_soccer,
                title: "Posição",
                value: "Meia Atacante",
              ),
              _ProfileDivider(height: 40),
              _ProfileInfoColumn(
                icon: Icons.calendar_month,
                title: "Nascimento",
                value: "24/03/2009",
              ),
              _ProfileDivider(height: 40),
              _ProfileInfoColumn(
                icon: Icons.shield,
                title: "Numero",
                value: "10",
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person, color: AppColors.lightGreen),
            label: Text(
              "Ver Peneiras",
              style: GoogleFonts.judson(
                fontSize: 16,
                color: AppColors.lightGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.lightGreen, width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(height: 25),
        const _ProfileSectionTitle(
          icon: Icons.info_outline,
          title: "Sobre",
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkBlue2,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.lightGreen,
              width: 1.5,
            ),
          ),
          child: const Text(
            "Jogador dedicado, com boa visao de jogo,passe preciso e chegada forte ao ataque. Buscando sempre evoluir e ajudar a equipe dentro de fora de campo.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class _ProfileInfoColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ProfileInfoColumn({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.lightGreen, size: 28),
        const SizedBox(height: 8),
        Text(title,
            style: const TextStyle(color: Colors.white60, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ProfileSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ProfileSectionTitle({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightGreen, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.judson(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileDivider extends StatelessWidget {
  final double height;

  const _ProfileDivider({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: height, color: Colors.white30);
  }
}
