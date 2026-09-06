import 'package:go_router/go_router.dart';

import 'package:peneiras/layout/main_shell.dart';
import 'package:peneiras/screens/content/add_peneira.dart';

import "./screens/initial.dart";
import "./screens/login.dart";

import './screens/cadastro/cadastro_endereco.dart';
import './screens/cadastro/cadastro.dart';
import './screens/cadastro/cadastro_time.dart';
import './screens/cadastro/cadastro_jogador.dart';
import './screens/cadastro/cadsatro_sucesso.dart';

import 'package:peneiras/screens/content/home.dart';
import 'screens/content/profile/perfil.dart';
import 'package:peneiras/screens/content/profile/editar_perfil.dart';

final GoRouter router = GoRouter(
  initialLocation: "/home",
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
        GoRoute(
          path: 'endereco',
          builder: (context, state) => const CadastroEnderecoScreen(),
        ),
        GoRoute(
          path: 'sucesso',
          builder: (context, state) => const CadastroSucessoScreen(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
            path: '/add-peneira',
            builder: (context, state) => const AddPeneiraScreen()),
        GoRoute(
            path: '/perfil',
            builder: (context, state) => const PerfilScreen(),
            routes: [
              GoRoute(
                path: 'editar-perfil',
                builder: (context, state) => const EditarPerfilScreen(),
              ),
            ]),
      ],
    ),
  ],
);
