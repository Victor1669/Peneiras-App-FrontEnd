import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/providers/club_controller.dart';
import 'package:peneiras/providers/is_clube_controller.dart';
import 'package:peneiras/providers/player_controller.dart';

import '../constants/app_colors.dart';

import 'package:peneiras/models/inputs.dart';
import 'package:peneiras/models/requests/auth_requests.dart';

import 'package:peneiras/utils/preferences_helper.dart';
import 'package:peneiras/services/auth_service.dart';

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
      footer: Column(
        spacing: 10,
        children: [
          _buildFooterLink(
            context,
            '/recuperar-senha',
            'Esqueceu sua senha?',
            ' Clique aqui',
          ),
          _buildFooterLink(
            context,
            '/cadastro',
            'Ainda nao tem conta?',
            ' Criar conta',
          ),
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
    BuildContext context,
    String route,
    String text1,
    String text2,
  ) {
    return TextButton(
      onPressed: () => context.push(route),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: text1,
              style: const TextStyle(color: Colors.white),
            ),
            TextSpan(
              text: text2,
              style: const TextStyle(color: AppColors.lightGreen),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  Future<void> _handleSubmit(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> data,
  ) async {
    final String email = data['email']?.toString() ?? '';
    final String password = data['password']?.toString() ?? '';

    try {
      final authService = AuthService();

      await authService.login(
        LoginRequest(
          email: email,
          password: password,
        ),
      );

      ref.invalidate(isClubeProvider);
      ref.invalidate(playerControllerProvider);
      ref.invalidate(clubControllerProvider);

      final bool hasSeenTutorial =
          PreferencesHelper.getBool('ja_viu_tutorial_home') ?? false;

      if (context.mounted) {
        context.replace(
          hasSeenTutorial ? '/home' : '/onboarding',
        );
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicForm(
      inputs: [
        getEmailInput(),
        getPasswordInput(),
      ],
      onSubmit: (data) => _handleSubmit(context, ref, data),
    );
  }
}
