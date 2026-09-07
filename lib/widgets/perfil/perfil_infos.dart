import 'package:flutter/material.dart';

import 'package:peneiras/constants/app_colors.dart';

class PerfilChip extends StatelessWidget {
  final String? label;
  const PerfilChip({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.sports_soccer,
          size: 15, color: AppColors.lightGreen),
      label: Text(label ?? "Sub-15"),
      backgroundColor: Colors.transparent,
      labelStyle: const TextStyle(color: Colors.white, fontSize: 13),
      side: const BorderSide(color: AppColors.lightGreen),
      visualDensity: VisualDensity.compact,
    );
  }
}

class PerfilInfo extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final String? value;
  const PerfilInfo({super.key, this.icon, this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon ?? Icons.sports_soccer,
            color: AppColors.lightGreen, size: 24),
        const SizedBox(height: 6),
        Text(title ?? "Categoria",
            style: const TextStyle(color: Colors.white60, fontSize: 11)),
        const SizedBox(height: 2),
        Text(value ?? "Sub-20",
            style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class PerfilContato extends StatelessWidget {
  final IconData? icon;
  final String? text;
  const PerfilContato({super.key, this.icon, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon ?? Icons.email, color: AppColors.lightGreen, size: 18),
          const SizedBox(width: 10),
          Text(text ?? "contato@peneirasfc.com",
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }
}
