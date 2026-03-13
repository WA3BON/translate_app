import 'package:flutter/material.dart';
import '../pages/privacy_policy_page.dart';
import '../pages/terms_page.dart';

class FooterLinks extends StatelessWidget {
  const FooterLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: const Text("Privacy Policy"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PrivacyPolicyPage(),
                ),
              );
            },
          ),
          const Text(" | "),
          TextButton(
            child: const Text("Terms"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TermsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
