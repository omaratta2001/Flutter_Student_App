import 'package:flutter/material.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/View/Story%20Screen/GeneratingScreen.dart';

enum SpeechTarget {
  character,
  place,
  count,
  time,
  idea,
}

class StoryScreenProvider with ChangeNotifier {
  final SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String _spokenTextCar = '';
  String _spokenTextPlace = '';
  String _spokenTextCount = '';
  String _spokenTextTime = '';
  String _spokenTextIdea = '';
  SpeechTarget? _currentTarget; // To know which field to update

  bool get isListening => _isListening;
  String get spokenTextCar => _spokenTextCar;
  String get spokenTextPlace => _spokenTextPlace;
  String get spokenTextCount => _spokenTextCount;
  String get spokenTextTime => _spokenTextTime;
  String get spokenTextIdea => _spokenTextIdea;

  StoryScreenProvider() {
    _speechService.initSpeech();
  }

  Future<void> toggleListening(SpeechTarget target) async {
    if (_isListening && _currentTarget == target) {
      // Stop listening if the same mic is tapped again
      _speechService.stopListening();
      _isListening = false;
      _currentTarget = null;
      notifyListeners();
    } else {
      // Stop any previous listening session before starting a new one
      if (_isListening) {
        _speechService.stopListening();
      }
      _isListening = true;
      _currentTarget = target;
      notifyListeners(); // Update UI to show listening state potentially

      await _speechService.startListening((text) {
        _updateTextForTarget(target, text);
        // Optionally stop listening automatically after getting a result
        // _isListening = false;
        // _currentTarget = null;
        // notifyListeners();
      });
      // If startListening completes without result callback (e.g., timeout), reset state
      if (_isListening && _currentTarget == target) {
        _isListening = false;
        _currentTarget = null;
        notifyListeners();
      }
    }
  }

  void _updateTextForTarget(SpeechTarget target, String text) {
    switch (target) {
      case SpeechTarget.character:
        _spokenTextCar = text;
        break;
      case SpeechTarget.place:
        _spokenTextPlace = text;
        break;
      case SpeechTarget.count:
        _spokenTextCount = text;
        break;
      case SpeechTarget.time:
        _spokenTextTime = text;
        break;
      case SpeechTarget.idea:
        _spokenTextIdea = text;
        break;
    }
    notifyListeners();
  }

  void clearAllTexts() {
    _spokenTextCar = '';
    _spokenTextPlace = '';
    _spokenTextCount = '';
    _spokenTextTime = '';
    _spokenTextIdea = '';
    if (_isListening) {
      _speechService.stopListening();
      _isListening = false;
      _currentTarget = null;
    }
    notifyListeners();
  }

  Future<void> generateStory(BuildContext context) async {
    // The logic for generating the prompt and navigating
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? age = prefs.getString('age');
    String? boy = prefs.getString(
        'Isboy'); // Assuming 'Isboy' stores gender info like 'boy' or 'girl'

    // Basic prompt structure
    String prompt =
        'أنا ${boy ?? 'طفل'}، عمري ${age ?? 'غير محدد'} سنوات، اريدك ان تكتب قصة، ضع عنوان مناسب للقصة، اكتب القصة بشكل متسلسل بها بداية ووسط ونهاية، راعي ان تكون الحبكة مناسبة لسني، وطول القصة مناسب لسني، راعي الكتابة باللغة العربية الفصحى المبسطة';

    // Add optional parts based on spoken text
    if (_spokenTextCar.isNotEmpty) {
      prompt += '، راعي ان يكون نوع الشخصيات $_spokenTextCar';
    }
    if (_spokenTextPlace.isNotEmpty) {
      prompt += '، راعي ان يكون المكان $_spokenTextPlace';
    }
    if (_spokenTextCount.isNotEmpty) {
      prompt += '، راعي ان يكون عدد الشخصيات $_spokenTextCount';
    }
    if (_spokenTextTime.isNotEmpty) {
      prompt += '، راعي ان يكون الزمن $_spokenTextTime';
    }
    if (_spokenTextIdea.isNotEmpty) {
      prompt += '، راعي ان تكون فكرة القصة عن $_spokenTextIdea';
    }

    // The English translation part seems specific, keeping it as is for now
    String englishTranslationPrompt = prompt +
        ' translate this to english without saying anything before or after only say the translation';

    print("Generated Arabic Prompt: $prompt");
    print("Prompt for English Translation: $englishTranslationPrompt");

    // Assuming GeminiTextService is correctly set up
    // GeminiTextService _gemini = GeminiTextService();
    // String? gentext = await _gemini.generateText(englishTranslationPrompt);
    // print("English Translation Result: $gentext"); // For debugging

    // Navigate to the GeneratingScreen
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return Generatingscreen(
        prompt: prompt, // Pass the original Arabic prompt
      );
    }));
  }

  @override
  void dispose() {
    _speechService.stopListening(); // Ensure speech service is stopped
    // Dispose other resources if any
    super.dispose();
  }
}
