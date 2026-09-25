import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/widgets/peneira_card.dart';

class HomePeneiras extends StatelessWidget {
  final List<PeneiraCardModel> peneiras;
  final bool isLoading;

  const HomePeneiras({
    super.key,
    required this.peneiras,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (peneiras.isEmpty) {
      return const SizedBox.shrink();
    }

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
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: peneiras.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: PeneiraCard(
                peneira: peneiras[index],
                onTap: (peneiraId) {
                  context.go("/home/peneira-details/$peneiraId");
                },
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
