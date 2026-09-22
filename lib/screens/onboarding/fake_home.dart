import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:peneiras/models/requests/auth_requests.dart';
import 'package:peneiras/services/auth_service.dart';

import 'package:peneiras/utils/preferences_helper.dart';
import 'package:peneiras/utils/global_keys.dart';

import 'package:peneiras/layout/home/home_destaques.dart';
import 'package:peneiras/layout/home/home_header.dart';
import 'package:peneiras/layout/screen_frame.dart';

class FakeHomeScreen extends StatefulWidget {
  const FakeHomeScreen({super.key});

  @override
  State<FakeHomeScreen> createState() => _FakeHomeScreenState();
}

class _FakeHomeScreenState extends State<FakeHomeScreen> {
  TutorialCoachMark? tutorialCoachMark;

  final GlobalKey _buttonKey = GlobalKey();
  final GlobalKey _searchKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _validarRefreshToken();
    _checkFirstTimeAndShowTutorial();
  }

  Future<void> _validarRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String refreshToken = prefs.getString('refresh_token') ?? "";

    try {
      await AuthService()
          .refreshtoken(RefreshTokenRequest(refreshToken: refreshToken));
    } catch (_) {
      if (!mounted) return;

      context.replace("/login");
    }
  }

  Future<void> _checkFirstTimeAndShowTutorial() async {
    final bool hasSeenTutorial =
        PreferencesHelper.getBool('ja_viu_tutorial_home') ?? false;

    if (!hasSeenTutorial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _createTutorial();
        _showTutorial();
      });
      await PreferencesHelper.saveBool('ja_viu_tutorial_home', true);
    }
  }

  void _createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      opacityShadow: 0.8,
      onFinish: () async {
        context.replace("/home");
        return true;
      },
      onClickTarget: (target) {
        if (target.identify == "targetProfile") {
          context.go('/onboarding/perfil');
        }
      },
      onSkip: () {
        context.replace("/home");
        return true;
      },
    );
  }

  void _showTutorial() {
    tutorialCoachMark?.show(
      context: context,
      rootOverlay: true,
    );
  }

  TargetFocus? _buildProfileTabTarget() {
    final renderObject = onboardingTabbarKey.currentContext?.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return null;

    final Size barSize = renderObject.size;
    final Offset barOffset = renderObject.localToGlobal(Offset.zero);
    final double itemWidth = barSize.width / 3;

    final Size itemSize = Size(itemWidth, barSize.height);
    final Offset itemOffset = Offset(
      barOffset.dx + itemWidth * 2,
      barOffset.dy,
    );

    return TargetFocus(
      identify: "targetProfile",
      targetPosition: TargetPosition(itemSize, itemOffset),
      shape: ShapeLightFocus.RRect,
      alignSkip: Alignment.topRight,
      radius: 16,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          builder: (context, controller) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Aba Perfil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Toque aqui para ir ao seu perfil e editar suas informações.",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  List<TargetFocus> _createTargets() {
    final List<TargetFocus> targets = [
      TargetFocus(
        identify: "targetSearch",
        keyTarget: _searchKey,
        shape: ShapeLightFocus.RRect,
        alignSkip: Alignment.topRight,
        radius: 30,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Busca Rápida",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Use este campo para procurar por itens rapidamente.",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    ];

    final TargetFocus? profileTarget = _buildProfileTabTarget();
    if (profileTarget != null) {
      targets.add(profileTarget);
    }

    return targets;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      title: "",
      showBackButton: false,
      rightWidget: IconButton(
        icon: const Icon(Icons.notifications),
        onPressed: () => print("Notificações clicadas"),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 20,
        children: [
          HomeHeader(
            searchKey: _searchKey,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const HomeDestaques(),
                  Container(
                    key: _buttonKey,
                    child: const SizedBox(height: 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
