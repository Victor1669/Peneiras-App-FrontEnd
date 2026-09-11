import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/models/enums.dart';
import 'package:peneiras/models/peneira_model.dart';

import 'package:peneiras/widgets/destaque_card.dart';

final List<PeneiraCardModel> mockDestaques = [
  const PeneiraCardModel(
      id: "1",
      about: "Teste",
      category: CategoryType.futebol,
      date: "2006-12-25",
      documents: DocumentType.cpf,
      hour: "15:00:00",
      modality: ModalityType.campo,
      uniforms: [UniformType.camisa],
      clubeImagem: "",
      clubeNome: "Teste",
      endereco: "03257150"),
  const PeneiraCardModel(
      id: "1",
      about: "Teste",
      category: CategoryType.futebol,
      date: "2006-12-25",
      documents: DocumentType.cpf,
      hour: "15:00:00",
      modality: ModalityType.campo,
      uniforms: [UniformType.camisa],
      clubeImagem: "",
      clubeNome: "Teste",
      endereco: "03257150"),
];

class HomeDestaques extends StatefulWidget {
  final List<PeneiraCardModel>? destaques;
  final bool isLoading;
  final void Function(PeneiraCardModel model)? onTapDestaque;

  const HomeDestaques({
    super.key,
    this.destaques,
    this.isLoading = false,
    this.onTapDestaque,
  });

  @override
  State<HomeDestaques> createState() => _HomeDestaquesState();
}

class _HomeDestaquesState extends State<HomeDestaques> {
  @override
  Widget build(BuildContext context) {
    final List<PeneiraCardModel> destaques = widget.destaques ?? mockDestaques;

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
        widget.isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: destaques.length,
                itemBuilder: (context, index) {
                  final model = destaques[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: DestaqueCard(
                      onTap: () => widget.onTapDestaque?.call(model),
                      destaque: model,
                    ),
                  );
                },
              ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
