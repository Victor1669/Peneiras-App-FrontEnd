import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:peneiras/app_router.dart';

import 'package:peneiras/utils/preferences_helper.dart';
import 'package:peneiras/utils/snackbar_helper.dart';

import 'package:peneiras/constants/app_colors.dart';

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
      scaffoldMessengerKey: rootScaffoldMessengerKey,
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
      routerConfig: router,
      title: 'Peneiras',
    );
  }
}
