import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/models/peneira_model.dart';
import '../constants/app_colors.dart';

class DestaqueCard extends StatelessWidget {
  final PeneiraModel model;
  final VoidCallback? onTap;

  const DestaqueCard({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0A192F),
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
              if (model.isNovo) const _BadgeNovo(),
              _Header(model: model),
              _InfoRow(icon: Icons.location_on, text: model.local),
              _InfoRow(icon: Icons.group, text: model.vagas),
              _InfoRow(icon: Icons.directions_run, text: model.distancia),
              _InfoRow(icon: Icons.calendar_today, text: model.data),
              _BotaoVerDetalhes(onPressed: onTap),
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
  final PeneiraModel model;
  const _Header({required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(model.logoAsset,
              width: 60, height: 60, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.titulo,
                style: GoogleFonts.judson(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                model.clube,
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.lightGreen),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }
}

class _BotaoVerDetalhes extends StatelessWidget {
  final VoidCallback? onPressed;
  const _BotaoVerDetalhes({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsGeometry.directional(top: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          'Ver detalhes',
          style: GoogleFonts.judson(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
