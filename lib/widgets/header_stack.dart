import 'package:flutter/material.dart';

class HeaderStack extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final double? fontSize;

  const HeaderStack({
    super.key,
    required this.onBack,
    required this.title,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: BackButton(
            onPressed: onBack,
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(fontSize: fontSize),
        ),
      ],
    );
  }
}
