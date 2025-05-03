import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiTextService {
  final String apiKey;

  GeminiTextService({this.apiKey = 'Geminiapikey'});

  Future<String?> generateText(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey',
    );

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final content =
            data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        return content ?? "No content returned.";
      } else {
        print("Error: ${response.statusCode}");
        print("Body: ${response.body}");
        return "Request failed.";
      }
    } catch (e) {
      print("Exception: $e");
      return "Something went wrong.";
    }
  }
}
