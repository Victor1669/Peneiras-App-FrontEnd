import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CadastroTimeScreen extends StatelessWidget {
  const CadastroTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CadastroTimeScreenBody();
  }
}

class CadastroTimeScreenBody extends StatelessWidget {
  const CadastroTimeScreenBody({super.key});

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
                      Column(children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: BackButton(
                                onPressed: () {
                                  context.pop();
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
                      ])
                    ]))));
  }
}
