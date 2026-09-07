import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/widgets/peneira_card.dart';

List<PeneiraCard> peneiras = const [
  PeneiraCard(
    peneira: PeneiraModel(
        titulo: "Peneira Sub-17",
        clube: "peneiras f.c",
        local: "São Paulo - SP",
        vagas: "40 vagas",
        distancia: "5 km",
        data: "25 de maio de 2026",
        logoAsset: "assets/logo.png"),
  ),
  PeneiraCard(
    peneira: PeneiraModel(
        titulo: "Peneira Sub-15",
        clube: "peneiras f.c",
        local: "São Paulo - SP",
        vagas: "30 vagas",
        distancia: "7 km",
        data: "25 de junho de 2026",
        logoAsset: "assets/logo.png"),
  )
];

class HomePeneiras extends StatelessWidget {
  const HomePeneiras({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.judson(fontSize: 24),
            children: const [
              TextSpan(text: 'Peneiras'),
            ],
          ),
        ),
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: peneiras.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: peneiras[index],
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
