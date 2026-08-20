import 'package:flutter/material.dart';
import 'package:peneiras/widgets/header_stack.dart';

class ScreenFrame extends StatelessWidget {
  final String title;
  final double? headerFontSize;
  final VoidCallback onBack;
  final Widget child;
  final Widget? footer;
  final bool showBackButton;
  final Widget? rightWidget;

  const ScreenFrame({
    super.key,
    required this.title,
    required this.onBack,
    required this.child,
    this.headerFontSize = 32,
    this.footer,
    this.showBackButton = true,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    HeaderStack(
                      onBack: onBack,
                      title: title,
                      fontSize: headerFontSize,
                      showBackButton: showBackButton,
                      rightWidget: rightWidget,
                    ),
                  ],
                ),
                Expanded(child: child),
                if (footer != null) footer!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
