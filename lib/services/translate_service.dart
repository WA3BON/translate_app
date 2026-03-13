import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslateService {
  static const String apiUrl =
      'https://yedwfhtnmf.execute-api.ap-northeast-1.amazonaws.com/prod/translate';

  static Future<String> translate({
    required String text,
    String source = 'ja',
    String target = 'es',
  }) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode({
        'text': text,
        'source': source,
        'target': target,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    final decoded = jsonDecode(response.body);
    return decoded['translatedText'];
  }
}
