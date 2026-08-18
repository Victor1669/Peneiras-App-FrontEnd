import 'package:flutter/material.dart';
import 'package:peneiras/widgets/header_stack.dart';

class ScreenFrame extends StatelessWidget {
  final String title;
  final double? headerFontSize;
  final VoidCallback onBack;
  final Widget child;
  final Widget? footer;

  const ScreenFrame({
    super.key,
    required this.title,
    required this.onBack,
    required this.child,
    this.headerFontSize = 32,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    HeaderStack(
                        onBack: onBack, title: title, fontSize: headerFontSize),
                    const SizedBox(height: 10),
                  ],
                ),
                Expanded(
                  child: child,
                ),
                if (footer != null) footer!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
