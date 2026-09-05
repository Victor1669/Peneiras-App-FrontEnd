import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:peneiras/models/requests/login_requests.dart';

import 'package:peneiras/services/auth_service.dart';
import 'package:peneiras/models/inputs.dart';

import '../constants/app_colors.dart';

import 'package:peneiras/layout/screen_frame.dart';

import 'package:peneiras/widgets/form/dynamic_form.dart';

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
        emailInput,
        passwordInput,
      ],
      onSubmit: (data) async {
        final String email = data['email']?.toString() ?? '';
        final String password = data['password']?.toString() ?? '';

        try {
          final authService = AuthService();

          final loginBody = LoginRequest(
            email: email,
            password: password,
          );

          await authService.login(loginBody);

          await authService.login(loginBody);

          if (context.mounted) {
            context.go("/home");
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.toString().replaceAll('Exception: ', '')),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        }
      },
    );
  }
}
