import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/widgets/destaque_card.dart';

final List<PeneiraModel> mockDestaques = [
  const PeneiraModel(
      titulo: "Peneira Sub-17",
      clube: "peneiras f.c",
      local: "São Paulo - SP",
      vagas: "40 vagas",
      distancia: "5 km",
      data: "25 de maio de 2026",
      logoAsset: "assets/logo.png"),
  const PeneiraModel(
      titulo: "Peneira Sub-15",
      clube: "peneiras f.c",
      local: "São Paulo - SP",
      vagas: "30 vagas",
      distancia: "7 km",
      data: "25 de junho de 2026",
      logoAsset: "assets/logo.png"),
];

class HomeDestaques extends StatelessWidget {
  final List<PeneiraModel>? destaques;
  final void Function(PeneiraModel model)? onTapDestaque;

  const HomeDestaques({
    super.key,
    this.destaques,
    this.onTapDestaque,
  });

  @override
  Widget build(BuildContext context) {
    final List<PeneiraModel> data = destaques ?? mockDestaques;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.judson(fontSize: 24),
            children: const [
              TextSpan(text: 'Destaques'),
            ],
          ),
        ),
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final model = data[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: DestaqueCard(
                    onTap: () => onTapDestaque?.call(model),
                    model: model,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
