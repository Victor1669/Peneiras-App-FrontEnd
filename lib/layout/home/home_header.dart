import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/constants/app_colors.dart';

import 'package:peneiras/providers/is_clube_controller.dart';
import 'package:peneiras/providers/player_controller.dart';
import 'package:peneiras/providers/club_controller.dart';

class HomeHeader extends ConsumerWidget {
  final GlobalKey? searchKey;

  const HomeHeader({super.key, this.searchKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClub = ref.watch(isClubeProvider);

    final asyncData = !isClub
        ? ref.watch(playerControllerProvider)
        : ref.watch(clubControllerProvider);

    final userName = asyncData.when(
      data: (entity) {
        if (entity == null) return isClub ? 'Clube' : 'User';
        final dataMap = entity.toJson();
        return dataMap['name'] ?? (isClub ? 'Clube' : 'User');
      },
      loading: () => '...',
      error: (_, __) => isClub ? 'Clube' : 'User',
    );

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
                text: userName,
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
        )
      ],
    );
  }
}
