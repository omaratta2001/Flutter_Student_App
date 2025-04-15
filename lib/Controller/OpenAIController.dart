import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String apiKey =
      "OpenRouterApiKey";
  static const String baseUrl = "https://openrouter.ai/api/v1/chat/completions";

  static Future<String> sendRequest(String userText) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          "Authorization": "Bearer $apiKey",
          "Content-Type": "application/json; charset=utf-8",
        },
        body: utf8.encode(jsonEncode({
          "model": "google/gemini-2.0-flash-exp:free",
          "messages": [
            {"role": "user", "content": userText}
          ]
        })),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data["choices"][0]["message"]["content"];
      } else {
        return "Error: ${utf8.decode(response.bodyBytes)}";
      }
    } catch (e) {
      return "Failed to connect: $e";
    }
  }
}
