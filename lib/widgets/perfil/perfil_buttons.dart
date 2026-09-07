import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';

class PerfilPrimaryButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  const PerfilPrimaryButton({super.key, this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed ?? () {},
        icon: Icon(icon ?? Icons.add, color: Colors.black, size: 20),
        label: Text(label ?? "Criar Peneira",
            style: GoogleFonts.judson(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightGreen,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

class PerfilSecondaryButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback? onPressed;
  const PerfilSecondaryButton(
      {super.key, this.label, this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed ?? () {},
        icon: Icon(icon ?? Icons.person, color: AppColors.lightGreen, size: 20),
        label: Text(label ?? "Ver Peneiras",
            style: GoogleFonts.judson(
                fontSize: 15,
                color: AppColors.lightGreen,
                fontWeight: FontWeight.bold)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.lightGreen),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 18),
        ),
      ),
    );
  }
}
