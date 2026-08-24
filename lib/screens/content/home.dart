import 'package:flutter/material.dart';
import 'package:peneiras/layout/screen_frame.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_colors.dart';

import 'package:peneiras/models/peneira_model.dart';

import '../../widgets/peneira_card.dart';
import '../../widgets/destaque_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    _carregarEPrintarToken();
  }

  Future<void> _carregarEPrintarToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    print("[DEBUG] Auth Token carregado na Home: $token");

    if (token != null && mounted) {
      /// TODO: Adicionar futuras requisições
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      title: "",
      onBack: () {},
      showBackButton: false,
      rightWidget: IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () => print("Notificações clicadas"),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          _HomeHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _HomeDestaques(),
                  _HomePeneiras(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: GoogleFonts.judson(fontSize: 32),
            children: const [
              TextSpan(text: 'Olá, ', style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: 'User!', style: TextStyle(color: AppColors.lightGreen)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SearchBar(
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

class _HomeDestaques extends StatelessWidget {
  const _HomeDestaques();

  @override
  Widget build(BuildContext context) {
    List<DestaqueCard> destaques = [
      DestaqueCard(
        onTap: () => {},
        model: const PeneiraModel(
            titulo: "Peneira Sub-17",
            clube: "peneiras f.c",
            local: "São Paulo - SP",
            vagas: "40 vagas",
            distancia: "5 km",
            data: "25 de maio de 2026",
            logoAsset: "assets/logo.png"),
      ),
      DestaqueCard(
        onTap: () => {},
        model: const PeneiraModel(
            titulo: "Peneira Sub-15",
            clube: "peneiras f.c",
            local: "São Paulo - SP",
            vagas: "30 vagas",
            distancia: "7 km",
            data: "25 de junho de 2026",
            logoAsset: "assets/logo.png"),
      )
    ];

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
              itemCount: destaques.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: destaques[index],
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

class _HomePeneiras extends StatelessWidget {
  const _HomePeneiras();

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
