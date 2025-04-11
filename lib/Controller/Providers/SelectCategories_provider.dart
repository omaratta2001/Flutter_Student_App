import 'package:flutter/material.dart';
import 'package:student_app/Controller/SpeakToText.dart';

class SpeechProvider extends ChangeNotifier {
  final SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String _spokenText = '';

  bool get isListening => _isListening;
  String get spokenText => _spokenText;

  Future<void> initSpeech() async {
    await _speechService.initSpeech();
  }

  Future<void> toggleListening() async {
    if (!_isListening) {
      _isListening = true;
      notifyListeners();

      await _speechService.startListening((text) {
        _spokenText = text;
        notifyListeners();
      });
    } else {
      _speechService.stopListening();
      _isListening = false;
      notifyListeners();
    }
  }
}
