import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';

final perfilCardDecoration = BoxDecoration(
  color: AppColors.darkBlue2,
  borderRadius: BorderRadius.circular(16),
  border: Border.all(color: AppColors.lightGreen),
);

class PerfilSectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const PerfilSectionTitle(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.lightGreen, size: 18),
        const SizedBox(width: 6),
        Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class PerfilDivider extends StatelessWidget {
  final double height;
  const PerfilDivider({super.key, required this.height});

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: height, color: Colors.white24);
}

class PerfilHeader extends StatelessWidget {
  final String? image;
  final String? name;
  final String? subtitle;
  final String? location;

  const PerfilHeader({
    super.key,
    this.image,
    this.name,
    this.subtitle,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    final finalImage = image ?? "assets/logo.png";
    final finalName = name ?? "Peneiras f.c";
    final finalSubtitle = subtitle ?? "Clube de futebol";
    final finalLocation = location ?? "São Paulo - SP";

    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.lightGreen, width: 2),
          ),
          child: ClipOval(child: Image.asset(finalImage, fit: BoxFit.cover)),
        ),
        const SizedBox(height: 12),
        Text(
          finalName,
          style: GoogleFonts.judson(
              fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(finalSubtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on,
                size: 16, color: AppColors.lightGreen),
            const SizedBox(width: 4),
            Text(finalLocation,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}

class PerfilCard extends StatelessWidget {
  final Widget child;
  const PerfilCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: perfilCardDecoration,
      child: child,
    );
  }
}
