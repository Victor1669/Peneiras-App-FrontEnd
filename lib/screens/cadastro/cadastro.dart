import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/widgets/transparent_button.dart';

import '../../constants/app_colors.dart';

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CadastroScreenBody();
  }
}

class CadastroScreenBody extends StatelessWidget {
  const CadastroScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 10,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: BackButton(
                            onPressed: () {
                              context.go("/");
                            },
                          ),
                        ),
                        const Text(
                          textAlign: TextAlign.center,
                          "Criar conta",
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsetsGeometry.all(20),
                      child: Text(
                        "Escolha o tipo de conta que melhor te descreve.",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Column(
                      spacing: 30,
                      children: [
                        CadastroButton(
                          text: "Sou Jogador",
                          description:
                              "Quero me cadastrar para encontrar oportunidades e participar de peneiras.",
                          icon: Icons.person,
                          onPressed: () => context.go("/cadastro/time"),
                        ),
                        CadastroButton(
                          text: "Sou Clube/Time",
                          description:
                              "Quero  cadastrar meu clube e publicar peneiras para encontrar talentos.",
                          icon: Icons.shield_sharp,
                          onPressed: () => context.go("/cadastro/jogador"),
                        )
                      ],
                    )
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/login');
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Já tem uma conta?',
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: ' Entrar',
                                style: TextStyle(color: AppColors.lightGreen)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class CadastroButton extends StatelessWidget {
  final String text;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;

  const CadastroButton(
      {super.key,
      required this.text,
      required this.description,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TransparentButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff35620D),
              border: Border.all(
                color: const Color(0xff5FFF37),
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(
                icon,
                size: 50,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            size: 35,
          )
        ],
      ),
    );
  }
}
