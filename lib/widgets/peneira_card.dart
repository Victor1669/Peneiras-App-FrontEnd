import 'package:flutter/material.dart';
import 'package:peneiras/constants/app_colors.dart';
import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/widgets/info_row.dart';

class PeneiraCard extends StatelessWidget {
  final PeneiraCardModel peneira;
  final VoidCallback? onTap;

  const PeneiraCard({
    super.key,
    required this.peneira,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.darkBlue2,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                peneira.clubeImagem?.isNotEmpty == true
                    ? peneira.clubeImagem!
                    : "assets/logo.png",
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/logo.png",
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    peneira.clubeNome,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    spacing: 10,
                    children: [
                      InfoRow(
                        text: peneira.category.value.toString(),
                        icon: Icons.category,
                      ),
                      InfoRow(
                        text: peneira.modality.value.toString(),
                        icon: Icons.model_training,
                      ),
                      InfoRow(
                        text: peneira.about,
                        icon: Icons.info,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right,
              color: Colors.white.withValues(alpha: 0.7),
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
