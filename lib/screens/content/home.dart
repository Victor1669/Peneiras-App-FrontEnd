import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:peneiras/models/peneira_model.dart';

import 'package:peneiras/providers/home_peneiras_controller.dart';
import 'package:peneiras/providers/peneira_enroll_controller.dart';

import 'package:peneiras/layout/home/home_header.dart';
import 'package:peneiras/layout/home/home_destaques.dart';
import 'package:peneiras/layout/home/home_peneiras.dart';
import 'package:peneiras/layout/screen_frame.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPeneiras = ref.watch(homePeneirasProvider);
    ref.read(peneiraEnrollsProvider);

    return ScreenFrame(
      title: "",
      showBackButton: false,
      child: asyncPeneiras.when(
        data: (todas) {
          final agora = DateTime.now();
          final limiteDestaque = agora.add(const Duration(days: 7));

          final List<PeneiraCardModel> destaques = [];
          final List<PeneiraCardModel> peneiras = [];

          for (final peneira in todas) {
            final dataPeneira = DateTime.tryParse(peneira.date);

            if (dataPeneira != null &&
                dataPeneira.isAfter(agora) &&
                dataPeneira.isBefore(limiteDestaque)) {
              destaques.add(peneira);
            } else {
              peneiras.add(peneira);
            }
          }

          final isEmpty = destaques.isEmpty && peneiras.isEmpty;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20,
              children: [
                const HomeHeader(),
                if (isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(
                      child: Text(
                        "Nenhuma peneira disponível no momento.",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else ...[
                  if (destaques.isNotEmpty)
                    HomeDestaques(
                      destaques: destaques,
                      isLoading: false,
                    ),
                  if (peneiras.isNotEmpty)
                    HomePeneiras(
                      peneiras: peneiras,
                      isLoading: false,
                    ),
                ],
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(
          child: Text('Erro ao carregar peneiras'),
        ),
      ),
    );
  }
}
