import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultPage extends StatelessWidget {
  final String originalText;
  final String translatedText;

  const ResultPage({
    super.key,
    required this.originalText,
    required this.translatedText,
    required String sourceLang,
    required String targetLang,
  });

  void _copy(BuildContext context) async {
    await Clipboard.setData(
      ClipboardData(text: translatedText),
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('翻訳結果をコピーしました'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 8,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                iconSize: 28,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          originalText,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          child: SelectableText(
                            translatedText,
                            style: const TextStyle(
                              fontSize: 34,
                              fontWeight: FontWeight.bold,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                mini: true,
                onPressed: () => _copy(context),
                child: const Icon(Icons.copy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
