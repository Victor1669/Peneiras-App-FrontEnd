import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:peneiras/utils/preferences_helper.dart';

import 'package:peneiras/constants/app_colors.dart';

import 'package:peneiras/layout/main_shell.dart';

import "./screens/initial.dart";

import "./screens/login.dart";

import './screens/cadastro/cadastro_endereco.dart';
import './screens/cadastro/cadastro.dart';
import './screens/cadastro/cadastro_time.dart';
import './screens/cadastro/cadastro_jogador.dart';
import "./screens/cadastro/upload_photo.dart";
import './screens/cadastro/cadsatro_sucesso.dart';

import 'package:peneiras/screens/content/home.dart';
import 'screens/content/profile/perfil.dart';
import 'package:peneiras/screens/content/profile/editar_perfil.dart';

final GoRouter _router = GoRouter(
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
          path: 'upload-photo',
          builder: (context, state) => const UploadPhotoScreen(),
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesHelper.init();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior:
          const MaterialScrollBehavior().copyWith(scrollbars: false),
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/fundo_app.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: child,
          ),
        );
      },
      color: AppColors.darkBlue1,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBlue1,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            padding: const EdgeInsets.all(20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: AppColors.lightGreen,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            )),
      ),
      routerConfig: _router,
      title: 'Peneiras',
    );
  }
}
