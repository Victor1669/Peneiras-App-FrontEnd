import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/input_config.dart';

import '../constants/app_colors.dart';

import 'package:peneiras/widgets/dynamic_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginScreenBody();
  }
}

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});

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
                          "Entrar",
                          style: TextStyle(fontSize: 32),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsetsGeometry.all(20),
                      child: Text("Bem vindo(a) de volta!"),
                    ),
                    const LoginForm(),
                  ],
                ),
                Column(
                  spacing: 10,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.push('/recuperar-senha');
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Esqueceu sua senha?',
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: ' Clique aqui',
                                style: TextStyle(color: AppColors.lightGreen)),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/cadastro');
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: 'Ainda nao tem conta?',
                                style: TextStyle(color: Colors.white)),
                            TextSpan(
                                text: ' Criar conta',
                                style: TextStyle(color: AppColors.lightGreen)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicForm(
      inputs: [
        InputConfig(
          key: "email",
          label: "E-mail",
          placeholder: "exemplo@email.com",
          keyboardType: TextInputType.emailAddress,
          icon: Icons.email,
          validator: (value) {
            if (value == null || !value.contains('@')) {
              return "E-mail inválido";
            }
            return null;
          },
        ),
        InputConfig(
          key: "password",
          label: "Senha",
          isPassword: true,
          icon: Icons.lock,
          validator: (value) =>
              (value?.length ?? 0) < 6 ? "Senha muito curta" : null,
        ),
      ],
      onSubmit: (data) {
        print("Dados recebidos: $data");
      },
    );
  }
}
