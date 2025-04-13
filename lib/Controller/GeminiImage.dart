import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class GeminiImageService {
  final String apiKey;

  GeminiImageService({this.apiKey = 'AIzaSyAphFM5yIY7hHjS7LtGwMPu3Ygw8BO_ey4'});

  Future<Uint8List?> generateImage1(String prompt, String aspect) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/imagen-3.0-generate-002:predict?key=AIzaSyAphFM5yIY7hHjS7LtGwMPu3Ygw8BO_ey4',
    );

    final headers = {
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "instances": [
        {
          "prompt": '''${prompt}
              '''
        }
      ],
      "parameters": {
        "sampleCount": 1,
        "aspectRatio": aspect,
      }
    });

    print(body);
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      print("Status Code: ${response.statusCode}");
      print("Raw Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final predictions = data['predictions'];
        if (predictions != null && predictions.isNotEmpty) {
          final base64Image = predictions[0]['bytesBase64Encoded'];
          if (base64Image != null) {
            return base64Decode(base64Image);
          }
        }

        print("No image returned in predictions.");
        return generateImage(prompt);
      } else {
        print("Request failed: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

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
