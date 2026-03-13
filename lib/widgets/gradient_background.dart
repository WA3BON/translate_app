// widgets/gradient_background.dart
import 'package:flutter/material.dart';

BoxDecoration gradientBackground(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: isDark
          ? [
              const Color(0xFF1C1B22),
              const Color(0xFF2B2733),
            ]
          : [
              const Color(0xFFF6F2FF),
              const Color(0xFFFDFBFF),
            ],
    ),
  );
}
