import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:peneiras/providers/is_clube_controller.dart';
import 'package:peneiras/services/auth_service.dart';
import 'package:peneiras/constants/app_colors.dart';
import 'package:peneiras/utils/preferences_helper.dart';
import 'package:peneiras/utils/global_keys.dart';

import 'package:peneiras/layout/screen_frame.dart';
import 'package:peneiras/layout/perfil/club_profile.dart';
import 'package:peneiras/layout/perfil/player_profile.dart';

class FakePerfilScreen extends ConsumerStatefulWidget {
  const FakePerfilScreen({super.key});

  @override
  ConsumerState<FakePerfilScreen> createState() => _FakePerfilScreenState();
}

class _FakePerfilScreenState extends ConsumerState<FakePerfilScreen> {
  TutorialCoachMark? tutorialCoachMark;

  final GlobalKey _settingsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _checkFirstTimeAndShowTutorial();
  }

  Future<void> _checkFirstTimeAndShowTutorial() async {
    final bool hasSeenTutorial =
        PreferencesHelper.getBool('ja_viu_tutorial_perfil') ?? false;

    if (!hasSeenTutorial) {
      _createTutorial();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) _showTutorial();
        });
      });
      await PreferencesHelper.saveBool('ja_viu_tutorial_perfil', true);
    }
  }

  void _createTutorial() {
    final isClub = ref.read(isClubeProvider);
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(isClub),
      colorShadow: Colors.black,
      opacityShadow: 0.8,
      onFinish: () {
        context.replace("/home");
        return true;
      },
      onSkip: () {
        context.replace("/home");
        return true;
      },
      onClickTarget: (target) {
        if (target.identify == "targetProfile") {
          context.go('/onboarding/perfil');
        }
      },
    );
  }

  void _showTutorial() {
    tutorialCoachMark?.show(
      context: context,
      rootOverlay: true,
    );
  }

  List<TargetFocus> _createTargets(bool isClub) {
    return [
      TargetFocus(
        identify: "targetSettings",
        keyTarget: _settingsKey,
        shape: ShapeLightFocus.Circle,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Editar Perfil",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Toque aqui para editar suas informações, foto e endereço.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      TargetFocus(
        identify: isClub ? "targetClubPerfilInfo" : "targetPlayerPerfilInfo",
        keyTarget: isClub ? perfilClubInfoKey : perfilPlayerInfoKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Informações do usuário",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Aqui estão as informações relevantes do perfil.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ];
  }

  void realizarLogout() async {
    await AuthService().logout();

    if (mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isClub = ref.watch(isClubeProvider);

    return ScreenFrame(
      title: isClub ? "Perfil de Clube" : "Perfil do Jogador",
      showBackButton: false,
      rightWidget: IconButton(
        key: _settingsKey,
        icon: const Icon(Icons.settings, color: AppColors.lightGreen),
        onPressed: () => context.go("/onboarding/editar-perfil"),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            isClub
                ? const ClubProfile(
                    isFake: true,
                  )
                : const PlayerProfile(
                    isFake: true,
                  ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: realizarLogout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Logout"),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
