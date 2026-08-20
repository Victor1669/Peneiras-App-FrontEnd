import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';

class CadastroSucessoScreen extends StatelessWidget {
  const CadastroSucessoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logo.png"),
            Padding(
              padding: const EdgeInsets.all(20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: const [
                    TextSpan(
                        text: 'Encontre sua proxima \n',
                        style: TextStyle(color: Colors.white)),
                    TextSpan(
                        text: 'oportunidade.',
                        style: TextStyle(color: AppColors.lightGreen)),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  context.go("/home");
                },
                child: const Text("Ingressar"))
          ],
        ),
      ),
    );
  }
}
