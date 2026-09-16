import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

import 'package:peneiras/models/peneira_model.dart';

import 'package:peneiras/widgets/info_row.dart';

class DestaqueCard extends StatelessWidget {
  final PeneiraCardModel destaque;
  final VoidCallback? onTap;

  const DestaqueCard({
    super.key,
    required this.destaque,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBlue2,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.lightGreen, width: 1.5),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            width: MediaQuery.sizeOf(context).width / 2,
            child: Center(
              child: AspectRatio(
                aspectRatio: 254 / 216,
                child:
                    Image.asset("assets/bola_na_rede.png", fit: BoxFit.contain),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              const _BadgeNovo(),
              _Header(model: destaque),
              InfoRow(
                icon: Icons.location_on,
                text: destaque.endereco!.isEmpty
                    ? "Sem endereço"
                    : destaque.endereco!,
              ),
              InfoRow(icon: Icons.calendar_today, text: destaque.date),
              InfoRow(icon: Icons.info, text: destaque.about),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: onTap,
                    child: Text(
                      'Ver detalhes',
                      style: GoogleFonts.judson(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class _BadgeNovo extends StatelessWidget {
  const _BadgeNovo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'Novo',
        style: GoogleFonts.judson(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final PeneiraCardModel model;
  const _Header({required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            model.clubeImagem?.isNotEmpty == true
                ? model.clubeImagem!
                : "assets/logo.png",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                "assets/logo.png",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Peneira de ${model.clubeNome}",
                style: GoogleFonts.judson(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                model.clubeNome,
                style: GoogleFonts.judson(
                  fontSize: 16,
                  color: AppColors.lightGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
