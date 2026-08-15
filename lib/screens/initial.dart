import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/responsive_width.dart';
import '../widgets/transparent_button.dart';
import '../constants/app_colors.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ResponsiveWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Coluna de Cima: Identidade Visual
                  Column(
                    spacing: 15,
                    children: [
                      Image.asset("assets/logo.png"),
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.judson(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: const [
                            TextSpan(text: 'PENE'),
                            TextSpan(
                              text: 'IRAS',
                              style: TextStyle(color: AppColors.lightGreen),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Oportunidades',
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: ' te esperam',
                                style: TextStyle(color: AppColors.lightGreen)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Coluna de Baixo: Ações
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => context.go("/cadastro"),
                        child: const Text('Criar conta'),
                      ),
                      const SizedBox(height: 12),
                      TransparentButton(
                        onPressed: () => context.go("/login"),
                        child: const Text('Entrar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
