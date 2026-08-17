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
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: ResponsiveWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    spacing: 15,
                    children: [
                      Image.asset("assets/logo.png"),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.judson(
                            fontSize: 50,
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
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          children: [
                            TextSpan(
                                text: 'Encontre sua proxima \n',
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: 'oportunidade.',
                                style: TextStyle(color: AppColors.lightGreen)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Botoes()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Botoes extends StatelessWidget {
  const Botoes({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.go("/cadastro"),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Icon(
                Icons.person,
                size: 25,
              ),
              Text('Criar conta')
            ],
          ),
        ),
        const SizedBox(height: 12),
        TransparentButton(
          onPressed: () => context.go("/login"),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              Icon(
                Icons.login,
                size: 25,
              ),
              Text('Entrar')
            ],
          ),
        ),
      ],
    );
  }
}
