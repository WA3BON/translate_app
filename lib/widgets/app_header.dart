// widgets/app_header.dart
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const AppHeader({
    super.key,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              const Text(
                'Traductor Lav 💜JP ↔ ES',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: onToggleTheme,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: const CircleBorder(),
              padding: EdgeInsets.zero,
              minimumSize: const Size(40, 40),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Icon(
              isDark ? Icons.wb_sunny : Icons.nightlight_round,
              color: Colors.white,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
