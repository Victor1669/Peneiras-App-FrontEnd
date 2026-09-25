import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderStack extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;
  final double? fontSize;
  final bool showBackButton;
  final Widget? rightWidget;

  const HeaderStack({
    super.key,
    this.onBack,
    required this.title,
    this.fontSize = 32,
    this.showBackButton = true,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (showBackButton)
          Align(
            alignment: Alignment.centerLeft,
            child: BackButton(
              onPressed: onBack ??
                  () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go("/home");
                    }
                  },
            ),
          ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: fontSize),
        ),
        if (rightWidget != null)
          Align(
            alignment: Alignment.centerRight,
            child: rightWidget!,
          ),
      ],
    );
  }
}
