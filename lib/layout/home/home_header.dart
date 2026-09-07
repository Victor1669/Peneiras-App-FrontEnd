import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';

class HomeHeader extends StatelessWidget {
  final String? userName;
  final GlobalKey? searchKey;
  final ValueChanged<String>? onSearchChanged;

  const HomeHeader({
    super.key,
    this.userName,
    this.searchKey,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: GoogleFonts.judson(fontSize: 32),
            children: [
              const TextSpan(
                  text: 'Olá, ', style: TextStyle(color: Colors.white)),
              TextSpan(
                text: '${userName ?? 'User'}!',
                style: const TextStyle(color: AppColors.lightGreen),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SearchBar(
          key: searchKey,
          hintText: 'Buscar oportunidades...',
          hintStyle: WidgetStateProperty.all(
            GoogleFonts.judson(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          textStyle: WidgetStateProperty.all(
            GoogleFonts.judson(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          leading: const Icon(
            Icons.search,
            color: AppColors.lightGreen,
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(
                color: Colors.white,
                width: 1.5,
              ),
            ),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16),
          ),
          onChanged: onSearchChanged,
        )
      ],
    );
  }
}
