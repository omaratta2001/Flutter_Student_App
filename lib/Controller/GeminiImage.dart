import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GeminiImageService {
  final String apiKey;

  GeminiImageService({this.apiKey = 'AIzaSyCEIqNk9qWlkHvJTL7osH8xQnl75RBe5xM'});

  Future<Uint8List?> generateImage(String prompt) async {
    final url =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash-exp-image-generation:generateContent?key=$apiKey';

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "contents": [
        {
          "parts": [
            {"text": prompt}
          ]
        }
      ],
      "generationConfig": {
        "responseModalities": ["Text", "Image"]
      }
    });
    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final dataString =
            json['candidates'][0]['content']['parts'][0]['inlineData']['data'];
        return base64Decode(dataString);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
