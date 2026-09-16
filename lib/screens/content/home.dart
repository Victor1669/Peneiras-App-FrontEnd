import 'package:flutter/material.dart';

import 'package:peneiras/models/peneira_model.dart';
import 'package:peneiras/services/peneira_service.dart';

import 'package:peneiras/layout/home/home_header.dart';
import 'package:peneiras/layout/home/home_destaques.dart';
import 'package:peneiras/layout/home/home_peneiras.dart';
import 'package:peneiras/layout/screen_frame.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PeneiraCardModel> destaques = [];
  List<PeneiraCardModel> peneiras = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarPeneiras();
  }

  Future<void> _carregarPeneiras() async {
    setState(() => isLoading = true);

    try {
      final todas = await PeneiraService().getAll();

      final agora = DateTime.now();
      final limiteDestaque = agora.add(const Duration(days: 7));

      final List<PeneiraCardModel> listaDestaques = [];
      final List<PeneiraCardModel> listaPeneiras = [];

      for (final peneira in todas) {
        final dataPeneira = DateTime.tryParse(peneira.date);

        if (dataPeneira != null &&
            dataPeneira.isAfter(agora) &&
            dataPeneira.isBefore(limiteDestaque)) {
          listaDestaques.add(peneira);
        } else {
          listaPeneiras.add(peneira);
        }
      }

      if (mounted) {
        setState(() {
          destaques = listaDestaques;
          peneiras = listaPeneiras;
        });
      }
    } catch (_) {
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEmpty = !isLoading && destaques.isEmpty && peneiras.isEmpty;

    return ScreenFrame(
      title: "",
      showBackButton: false,
      rightWidget: IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () => print("Notificações clicadas"),
      ),
      child: SingleChildScrollView(
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
              HomeDestaques(
                destaques: destaques,
                isLoading: isLoading,
              ),
              HomePeneiras(
                peneiras: peneiras,
                isLoading: isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
