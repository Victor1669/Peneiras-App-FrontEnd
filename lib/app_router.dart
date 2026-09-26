import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/layout/main_shell.dart';
import 'package:peneiras/providers/auth_controller.dart';
import 'package:peneiras/utils/secure_store_helper.dart';

import "./screens/initial.dart";
import "./screens/login.dart";

import './screens/cadastro/cadastro.dart';
import './screens/cadastro/cadastro_time.dart';
import './screens/cadastro/cadastro_jogador.dart';

import 'package:peneiras/screens/content/home.dart';
import 'package:peneiras/screens/content/perfil/perfil.dart';
import 'package:peneiras/screens/content/perfil/editar_perfil.dart';

import 'package:peneiras/screens/content/peneiras/add_peneira.dart';
import 'package:peneiras/screens/content/peneiras/edit_peneira.dart';
import 'package:peneiras/screens/content/peneiras/my_peneiras.dart';
import 'package:peneiras/screens/content/peneiras/peneira_details.dart';

import 'package:peneiras/screens/onboarding/fake_home.dart';
import 'package:peneiras/screens/onboarding/fake_perfil.dart';

Page<void> _noTransitionPage(Widget child) {
  return NoTransitionPage(child: child);
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/",
    redirect: (context, state) async {
      // Só faz validação de estiver na rota raiz
      if (state.matchedLocation != "/") {
        return null;
      }

      // Se não tiver token, vai pro fluxo normal
      final refreshToken = await SecureStorageHelper.getString('refresh_token');

      if (refreshToken == null || refreshToken.isEmpty) {
        return null;
      }

      try {
        // verifica se está autenticado
        final isAutenticado = await ref.read(authStateProvider.future);

        // Se não estiver, vai pro login
        if (!isAutenticado) {
          return '/login';
        }
        return '/home';
      } catch (e) {
        return '/login';
      }
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const InitialScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/cadastro',
        builder: (context, state) => const CadastroScreen(),
        routes: [
          GoRoute(
            path: 'jogador',
            builder: (context, state) => const CadastroJogadorScreen(),
          ),
          GoRoute(
            path: 'time',
            builder: (context, state) => const CadastroTimeScreen(),
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(
            baseRoute: "home",
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                _noTransitionPage(const HomeScreen()),
          ),
          GoRoute(
            path: '/home/add-peneira',
            pageBuilder: (context, state) =>
                _noTransitionPage(const AddPeneiraScreen()),
          ),
          GoRoute(
            path: '/home/my-peneiras',
            pageBuilder: (context, state) =>
                _noTransitionPage(const MyPeneirasScreen()),
          ),
          GoRoute(
            path: '/home/edit-peneira/:id',
            builder: (context, state) {
              final peneiraId = state.pathParameters['id']!;
              return EditPeneiraScreen(peneiraId: peneiraId);
            },
          ),
          GoRoute(
            path: '/home/peneira-details/:id',
            builder: (context, state) {
              final peneiraId = state.pathParameters['id']!;
              return PeneiraDetailsScreen(peneiraId: peneiraId);
            },
          ),
          GoRoute(
            path: '/home/perfil',
            pageBuilder: (context, state) =>
                _noTransitionPage(const PerfilScreen()),
            routes: [
              GoRoute(
                path: 'editar-perfil',
                pageBuilder: (context, state) =>
                    _noTransitionPage(const EditarPerfilScreen()),
              ),
            ],
          ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(baseRoute: "onboarding", child: child);
        },
        routes: [
          GoRoute(
            path: '/onboarding',
            pageBuilder: (context, state) =>
                _noTransitionPage(FakeHomeScreen()),
          ),
          GoRoute(
            path: '/onboarding/perfil',
            pageBuilder: (context, state) =>
                _noTransitionPage(const FakePerfilScreen()),
            routes: [
              GoRoute(
                path: '/onboarding/editar-perfil',
                pageBuilder: (context, state) =>
                    _noTransitionPage(const EditarPerfilScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
