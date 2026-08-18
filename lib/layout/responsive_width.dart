import 'package:flutter/material.dart';

class ResponsiveWidth extends StatelessWidget {
  final Widget child;

  const ResponsiveWidth({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double targetWidth = MediaQuery.of(context).size.width * 0.9;

    return SizedBox(
      width: targetWidth,
      child: child,
    );
  }
}
