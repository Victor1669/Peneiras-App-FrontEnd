import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/layout/home_tabbar.dart';
import 'package:peneiras/utils/global_keys.dart';
import '../constants/app_colors.dart';

class MainShell extends StatelessWidget {
  final String baseRoute;
  final Widget child;

  const MainShell({super.key, required this.baseRoute, required this.child});

  @override
  Widget build(BuildContext context) {
    final GlobalKey tabbarKey =
        baseRoute == "home" ? homeTabbarKey : onboardingTabbarKey;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: child,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.darkBlue1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              _AddPeneiraButton(baseRoute: baseRoute),
              const SizedBox(height: 20),
              HomeTabbar(
                baseRoute: baseRoute,
                tabbarKey: tabbarKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPeneiraButton extends StatelessWidget {
  final String baseRoute;

  const _AddPeneiraButton({required this.baseRoute});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/$baseRoute/add-peneira');
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 28,
        ),
      ),
    );
  }
}
