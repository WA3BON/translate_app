import 'package:flutter/material.dart';
import 'package:translate_app/pages/result_page.dart';
import 'package:translate_app/constants/error_message.dart';
import 'package:translate_app/widgets/app_header.dart';
import 'package:translate_app/widgets/footer_links.dart';
import 'package:translate_app/widgets/primary_button.dart';
import 'package:translate_app/widgets/gradient_background.dart';
import 'package:translate_app/services/translate_service.dart';

class InputPage extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const InputPage({
    super.key,
    required this.onToggleTheme,
  });

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _controller = TextEditingController();

  bool _loading = false;

  /// ===== 言語設定 =====
  String _source = "ja";
  String _target = "es";

  int get _textLength => _controller.text.length;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// ===== 言語表示 =====
  String get sourceLabel => _source == "ja" ? "日本語" : "Español";
  String get targetLabel => _target == "es" ? "Español" : "日本語";

  /// ===== 言語入れ替え =====
  void _swapLanguage() {
    setState(() {
      final tmp = _source;
      _source = _target;
      _target = tmp;
    });
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _translate() async {
    final text = _controller.text.trim();

    /// ===== Validation =====
    if (text.isEmpty) {
      _showSnackBar(errorMessages["EMPTY_TEXT"]!);
      return;
    }

    if (text.length > 500) {
      _showSnackBar(errorMessages["TEXT_TOO_LONG"]!);
      return;
    }

    setState(() => _loading = true);

    try {
      final result = await TranslateService.translate(
        text: text,
        source: _source,
        target: _target,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            originalText: text,
            translatedText: result,
            sourceLang: _source,
            targetLang: _target,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(errorMessages["INTERNAL_ERROR"]!);
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const FooterLinks(),
      body: Container(
        decoration: gradientBackground(context),
        child: SafeArea(
          child: Column(
            children: [
              AppHeader(onToggleTheme: widget.onToggleTheme),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  sourceLabel,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: _swapLanguage,
                                  icon: const Icon(Icons.swap_horiz),
                                ),
                                Text(
                                  targetLabel,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    TextField(
                                      controller: _controller,
                                      maxLines: 6,
                                      onChanged: (_) => setState(() {}),
                                      decoration: InputDecoration(
                                        hintText: _source == "ja"
                                            ? '翻訳したい日本語を入力'
                                            : 'Ingrese texto en español',
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '$_textLength / 500',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _textLength > 500
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Center(
                              child: PrimaryButton(
                                label: _loading ? '翻訳中...' : '翻訳する',
                                isLoading: _loading,
                                onPressed: _loading ? null : _translate,
                              ),
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
