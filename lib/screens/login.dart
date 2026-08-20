import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/layout/screen_frame.dart';

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
    return ScreenFrame(
      title: "Entrar",
      onBack: () => context.go("/"),
      footer: Column(
        spacing: 10,
        children: [
          _buildFooterLink(context, '/recuperar-senha', 'Esqueceu sua senha?',
              ' Clique aqui'),
          _buildFooterLink(
              context, '/cadastro', 'Ainda nao tem conta?', ' Criar conta'),
        ],
      ),
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text("Bem vindo(a) de volta!"),
          ),
          LoginForm(),
        ],
      ),
    );
  }

  Widget _buildFooterLink(
      BuildContext context, String route, String text1, String text2) {
    return TextButton(
      onPressed: () => context.push(route),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(text: text1, style: const TextStyle(color: Colors.white)),
            TextSpan(
                text: text2,
                style: const TextStyle(color: AppColors.lightGreen)),
          ],
        ),
      ),
    );
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
        context.go("/home");
      },
    );
  }
}
