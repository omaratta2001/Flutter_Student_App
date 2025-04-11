import 'dart:async';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechService {
  final FlutterTts _flutterTts = FlutterTts();

  final SpeechToText _speech = SpeechToText();
  bool _isAvailable = false;

  Future<void> initSpeech() async {
    _isAvailable = await _speech.initialize();
  }

  Future<void> startListening(Function(String) onResult) async {
    if (_isAvailable) {
      await _flutterTts.stop();

      _speech.listen(
        onResult: (result) => onResult(result.recognizedWords),
        localeId: 'ar-EG',
      );
    }
  }

  void stopListening() {
    _speech.stop();
  }

  bool get isListening => _speech.isListening;
}
