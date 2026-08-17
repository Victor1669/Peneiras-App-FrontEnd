import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BackButton(
              onPressed: () {
                context.go("/");
              },
            ),
            const Text("Criar conta"),
          ],
        ),
      ),
    );
  }
}
