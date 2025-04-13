import 'package:flutter/material.dart';
import 'package:student_app/Controller/FlutterTTS.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/SpeakToText.dart';

class generatingactscreenprovider extends ChangeNotifier {
  TTSService speak = TTSService();
  String _prompit = '';
  final SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String _spokenText = '';
  String _genais = '';
  String? _recivedmessage = '';
  bool _isGeneratingtext = true;
  late Future<void> genai;
  bool isanswer = false;
  bool isgenerating = false;
  GeminiTextService _gemin = new GeminiTextService();

  bool get isListening => _isListening;
  String get spokenText => _spokenText;
  String get genais => _genais;
  String? get recivedmessage => _recivedmessage;
  String? get prompit => _prompit;
  bool get isGeneratingtext => _isGeneratingtext;
  bool get _isanswer => isanswer;
  bool get _isgenerating => isgenerating;

  void setValue(String newValue) {
    isanswer = false;
    isgenerating = false;
    _prompit = newValue;
    _genais = '';
    _isGeneratingtext = true;
    _recivedmessage = '';
    _isListening = false;
    _spokenText = '';
    genai = _generatetext();
    notifyListeners();
  }

  Future<void> initSpeech() async {
    await _speechService.initSpeech();
  }

  Future<void> _generatetext() async {
    try {
      final textss = await _gemin.generateText(_prompit);
      print(textss);
      _genais = textss!;
      _isGeneratingtext = false;
      notifyListeners();
      return genai;
    } catch (e) {
      _isGeneratingtext = false;
      notifyListeners();

      throw e; // Re-throw to be caught by FutureBuilder
    }
  }

  Future<void> toggleListening() async {
    if (!_isListening) {
      _isListening = true;
      notifyListeners();

      await _speechService.startListening((text) {
        _spokenText = text;
        notifyListeners();
      });
      notifyListeners();
    } else {
      _speechService.stopListening();
      _isListening = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    speak.stop(); // Stop TTS when the widget is disposed

    super.dispose();
  }

  void regenrate() {
    isanswer = false;
    isgenerating = false;

    _genais = '';
    _isGeneratingtext = true;
    _recivedmessage = '';
    _isListening = false;
    _spokenText = '';
    genai = _generatetext();
    print(_prompit);
    notifyListeners();
  }

  Future<void> generateanser() async {
    isgenerating = true;
    isanswer = true;
    notifyListeners();

    // final textss = await _gemin
    //     .generateText('أنا عايز بس السوال من الكلام ده: ${prompit}');
    print(_genais);
    String prom =
        'هل الإجابة $_spokenText هي إجابة صحيحة للسؤال ${_genais}، اكتب كلمة صح إذا كانت الإجابة صحيحة وكلمة خطأ إذا كانت الإجابة خاطئة، وفي كلتا الحالتين قدم الإجابة الصحيحة';
    String proms = 'هل الإجابة ' +
        _spokenText +
        ' هي إجابة صحيحة للسؤال ' +
        _genais! +
        '، اكتب كلمة صح إذا كانت الإجابة صحيحة وكلمة خطأ إذا كانت الإجابة خاطئة، وفي كلتا الحالتين قدم الإجابة الصحيحة';
    print(proms);
    _recivedmessage = await _gemin.generateText(proms);
    //print(_recivedmessage);
    isgenerating = false;
    notifyListeners();
  }

  void speaktext() {
    speak.speakText(_genais);
    notifyListeners();
  }

  void speakanswer() {
    speak.speakText(recivedmessage!);
    notifyListeners();
  }
}
