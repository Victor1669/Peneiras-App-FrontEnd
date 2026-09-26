import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';
import 'package:peneiras/providers/player_controller.dart';
import 'package:peneiras/utils/global_keys.dart';

import 'package:peneiras/widgets/perfil/perfil_infos.dart';
import 'package:peneiras/widgets/perfil/perfil_ui.dart';

class PlayerProfile extends ConsumerWidget {
  final bool isFake;

  const PlayerProfile({super.key, this.isFake = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (isFake) {
      return _buildProfileContent(
        context,
        image: "assets/logo.png",
        name: "User",
        position: "Meia Atacante",
        birthDate: "24/03/2009",
        dominantFoot: "Direito",
        aboutText:
            "Jogador dedicado, com boa visão de jogo, passe preciso e chegada forte ao ataque. Buscando sempre evoluir e ajudar a equipe dentro e fora de campo.",
        height: "180",
      );
    }

    final playerAsync = ref.watch(playerControllerProvider);

    return playerAsync.when(
      data: (player) {
        if (player == null) {
          return const Center(
            child: Text(
              "Nenhum dado de perfil encontrado",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return _buildProfileContent(
          context,
          image: player.userImg ?? "assets/logo.png",
          name: player.name,
          position: player.position ?? "Não informada",
          birthDate: player.birthDate ?? "Não informada",
          dominantFoot: player.dominantFoot ?? "Não informado",
          aboutText: "Nenhuma descrição informada.",
          height: player.heightCm?.toString() ?? "0",
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.lightGreen),
      ),
      error: (err, stack) => const Center(
        child: Text(
          "Erro ao carregar perfil",
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildProfileContent(
    BuildContext context, {
    required String image,
    required String name,
    required String position,
    required String birthDate,
    required String dominantFoot,
    required String aboutText,
    required String height,
  }) {
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
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_soccer,
                size: 15, color: AppColors.lightGreen),
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
                  icon: Icons.height, title: "Altura", value: "$height cm"),
              const PerfilDivider(height: 36),
              PerfilInfo(
                  icon: Icons.calendar_month,
                  title: "Nascimento",
                  value: birthDate),
              const PerfilDivider(height: 36),
              PerfilInfo(
                  icon: Icons.circle,
                  title: "Pé dominante",
                  value: dominantFoot),
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
