import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:peneiras/providers/is_clube_controller.dart';

import '../constants/app_colors.dart';

class HomeTabbar extends ConsumerWidget {
  final String baseRoute;
  final GlobalKey tabbarKey;

  const HomeTabbar({
    super.key,
    required this.baseRoute,
    required this.tabbarKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isClube = ref.watch(isClubeProvider);

    return ClipRRect(
      key: tabbarKey,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
        selectedItemColor: AppColors.lightGreen,
        unselectedItemColor: Colors.white54,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.assignment),
            label: isClube ? 'Peneiras' : 'Inscrições',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;

    if (location.startsWith('/$baseRoute/my-peneiras')) return 1;
    if (location.startsWith('/$baseRoute/perfil')) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/$baseRoute');
        break;
      case 1:
        context.go('/$baseRoute/my-peneiras');
        break;
      case 2:
        context.go('/$baseRoute/perfil');
        break;
    }
  }
}
