import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSService extends ChangeNotifier {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> speakText(String text) async {
    try {
      if (_isArabic(text)) {
        await _flutterTts.setLanguage("ar-SA"); // Set language to Arabic
        print("TTS: Language set to Arabic"); // Debug log
      } else {
        await _flutterTts.setLanguage("en-US"); // Set language to English
        print("TTS: Language set to English"); // Debug log
      }

      await _flutterTts.setPitch(1.0); // Set pitch (1.0 is normal)
      await _flutterTts
          .setSpeechRate(0.5); // Set speech rate (0.5 is half speed)
      await _flutterTts.speak(text); // Speak the text
      notifyListeners();
      print("TTS: Speaking text: $text"); // Debug log
    } catch (e) {
      print("TTS Error: $e"); // Debug log
    }
  }

  void stop() {
    _flutterTts.stop();
    notifyListeners();
  }

  bool _isArabic(String text) {
    final arabicRegex = RegExp(r'[\u0600-\u06FF]');
    return arabicRegex.hasMatch(text);
  }
}
