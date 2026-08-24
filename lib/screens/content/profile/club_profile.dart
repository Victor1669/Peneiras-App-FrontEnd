import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';

class ClubProfile extends StatelessWidget {
  const ClubProfile({super.key});

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
          "Peneiras f.c",
          style: GoogleFonts.judson(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          "Clube de futebol",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 5),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 16, color: AppColors.lightGreen),
            SizedBox(width: 6),
            Text("São Paulo - SP",
                style: TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 25),
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline,
                      color: AppColors.lightGreen, size: 20),
                  SizedBox(width: 8),
                  Text(
                    "Sobre",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Formando talentos desde 1999\nFormando talentos desde 1999\nFormando talentos desde 1999",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Categorias",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    avatar: const Icon(Icons.sports_soccer,
                        size: 16, color: AppColors.lightGreen),
                    label: const Text("Sub-15"),
                    backgroundColor: Colors.transparent,
                    labelStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: AppColors.lightGreen),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(Icons.sports_soccer,
                        size: 16, color: AppColors.lightGreen),
                    label: const Text("Sub-17"),
                    backgroundColor: Colors.transparent,
                    labelStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: AppColors.lightGreen),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(Icons.sports_soccer,
                        size: 16, color: AppColors.lightGreen),
                    label: const Text("Profissional"),
                    backgroundColor: Colors.transparent,
                    labelStyle: const TextStyle(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: const BorderSide(color: AppColors.lightGreen),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
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
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contato",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.email, color: AppColors.lightGreen),
                title: Text("contato@peneirasfc.com",
                    style: TextStyle(color: Colors.white70)),
                dense: true,
              ),
              ListTile(
                leading: Icon(Icons.phone, color: AppColors.lightGreen),
                title: Text("(11) 99999-9999",
                    style: TextStyle(color: Colors.white70)),
                dense: true,
              ),
              ListTile(
                leading: Icon(Icons.camera_alt, color: AppColors.lightGreen),
                title: Text("@peneirasfc",
                    style: TextStyle(color: Colors.white70)),
                dense: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.black),
            label: Text(
              "Criar Peneira",
              style: GoogleFonts.judson(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.lightGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
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
      ],
    );
  }
}
