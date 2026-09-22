import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';
import 'package:peneiras/utils/global_keys.dart';
import 'package:peneiras/providers/club_controller.dart';

import 'package:peneiras/widgets/perfil/perfil_infos.dart';
import 'package:peneiras/widgets/perfil/perfil_ui.dart';

class ClubProfile extends ConsumerWidget {
  final bool isFake;

  const ClubProfile({super.key, this.isFake = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isFake) {
      return _buildProfileContent(
        context,
        image: "assets/logo.png",
        name: "Peneiras f.c",
        category: "FUTEBOL",
        location: "CEP: 06815-630, Nº 11",
        email: "contato@peneirasfc.com",
        phone: "(11) 99999-9999",
        whatsapp: "(11) 99999-9999",
        socialMedia: "@peneirasfc",
      );
    }

    final clubAsync = ref.watch(clubControllerProvider);

    return clubAsync.when(
      data: (club) {
        final address = club.address;
        final locationStr = address != null
            ? "CEP: ${address.cep}, Nº ${address.numero}"
            : "Não informada";

        return _buildProfileContent(
          context,
          image: club.userImg ?? "assets/logo.png",
          name: club.name ?? "Nome não informado",
          category: club.category ?? "Não informada",
          location: locationStr,
          email: club.email ?? "Não informado",
          phone: club.phone ?? "Não informado",
          whatsapp: club.whatsapp ?? "Não informado",
          socialMedia: club.instagramAccount ?? "Não informado",
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.lightGreen),
      ),
      error: (err, stack) => const Center(
        child: Text(
          "Erro ao carregar perfil do clube",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context, {
    required String image,
    required String name,
    required String category,
    required String location,
    required String email,
    required String phone,
    required String whatsapp,
    required String socialMedia,
  }) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.lightGreen, width: 2),
            ),
            child: ClipOval(
              child: image.startsWith('http')
                  ? Image.network(image, fit: BoxFit.cover)
                  : Image.asset("assets/logo.png", fit: BoxFit.cover),
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
          const SizedBox(height: 4),
          Text(
            category,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on,
                  size: 16, color: AppColors.lightGreen),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 20),
          PerfilCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.lightGreen, size: 18),
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
              ],
            ),
          ),
          const SizedBox(height: 16),
          PerfilCard(
            key: perfilClubInfoKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categorias",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    PerfilChip(label: category),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PerfilCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contato",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                PerfilContato(icon: Icons.email, text: email),
                PerfilContato(icon: Icons.phone, text: phone),
                PerfilContato(icon: Icons.phone_android, text: whatsapp),
                PerfilContato(icon: Icons.camera_alt, text: socialMedia),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, color: Colors.black, size: 20),
              label: Text(
                "Criar Peneira",
                style: GoogleFonts.judson(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person,
                  color: AppColors.lightGreen, size: 20),
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
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
