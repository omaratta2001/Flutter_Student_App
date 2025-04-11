// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:student_app/Controller/FlutterTTS.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:student_app/Controller/spans.dart';

class Generatingactscreen extends StatefulWidget {
  final String prompit;
  const Generatingactscreen({
    super.key,
    required this.prompit,
  });
  @override
  State<Generatingactscreen> createState() => _GeneratingactscreenState();
}

class _GeneratingactscreenState extends State<Generatingactscreen> {
  TTSService speak = TTSService();

  late Future<void> genai;
  String genais = '';
  String titlename = '';
  bool _isGeneratingtext = true;
  Uint8List? imageBytes;
  bool loading = true;
  String? gentext = '';

  SpeechService _speechService = SpeechService();
  String? recivedmessage = '';
  bool _isListening = false;
  String _spokenText = '';

  @override
  void initState() {
    super.initState();
    _speechService.initSpeech();

    // Start generating image immediately when screen loads
    genai = _generatetext();
  }

  @override
  void dispose() {
    speak.stop(); // Stop TTS when the widget is disposed

    super.dispose();
  }

  Future<void> _generatetext() async {
    try {
      GeminiTextService _gemin = new GeminiTextService();

      final textss = await _gemin.generateText(widget.prompit);
      print(textss);
      genais = textss!;

      setState(() => _isGeneratingtext = false);
      return genai;
    } catch (e) {
      setState(() => _isGeneratingtext = false);
      throw e; // Re-throw to be caught by FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 100,
        leadingWidth: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Transform.translate(
              offset: Offset(-20, -20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      genais = '';
                      titlename = '';
                      _isGeneratingtext = true;
                      imageBytes;
                      loading = true;
                      gentext = '';
                      recivedmessage = '';
                      _isListening = false;
                      _spokenText = '';
                      setState(() {
                        genai = _generatetext();
                      });
                    },
                    child: Image.asset(
                      "Assets/Regenerate.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      "Assets/Layer9.png",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: Transform.translate(
            offset: Offset(-37, -15),
            child: Image.asset(
              "Assets/activity.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/background1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // SizedBox(
            //   height: 80,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: MediaQuery.of(context).size.height / 1.85,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Assets/Greenbox.png"),
                              opacity: 0.8,
                              fit: BoxFit.fill),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.075,
                              right: 10,
                              left: 15,
                              top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffedf2d7),
                            ),
                            child: _isGeneratingtext
                                ? Center(child: CircularProgressIndicator())
                                : SingleChildScrollView(
                                    child: buildStyledText(genais)),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(-MediaQuery.of(context).size.width / 7, -50),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("Assets/icon.png"),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            "السؤال",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-MediaQuery.of(context).size.width / 2.8,
                          MediaQuery.of(context).size.height / 2.8),
                      child: InkWell(
                          onTap: () {
                            speak.speakText(genais);
                          },
                          child: Image.asset(
                            "Assets/listen.png",
                            width: 75,
                            height: 75,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: MediaQuery.of(context).size.height / 1.85,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("Assets/Greenbox.png"),
                              opacity: 0.8,
                              fit: BoxFit.fill),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.075,
                              right: 10,
                              left: 15,
                              top: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffedf2d7),
                            ),
                            child: buildStyledText(_spokenText),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset:
                          Offset(-MediaQuery.of(context).size.width / 7, -50),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("Assets/icon.png"),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: Text(
                            "إجابتك",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(-MediaQuery.of(context).size.width / 2.8,
                          MediaQuery.of(context).size.height / 2.8),
                      child: InkWell(
                        onTap: () async {
                          if (!_isListening) {
                            setState(() => _isListening = true);
                            await _speechService.startListening((text) {
                              setState(() async {
                                _spokenText = text;
                              });
                            });
                          } else {
                            _speechService.stopListening();

                            setState(() async {
                              _isListening = false;
                            });
                          }

                          setState(() async {
                            GeminiTextService _gemin = new GeminiTextService();

                            final textss = await _gemin.generateText(
                                'أنا عايز بس السوال من الكلام ده: ${widget.prompit}');
                            String prom =
                                'هل الإجابة $_spokenText هي إجابة صحيحة للسؤال ${textss!}، اكتب كلمة صح إذا كانت الإجابة صحيحة وكلمة خطأ إذا كانت الإجابة خاطئة، وفي كلتا الحالتين قدم الإجابة الصحيحة';
                            recivedmessage = await _gemin.generateText(prom);
                            print(recivedmessage);
                          });
                        },
                        child: Image.asset(
                          "Assets/Mic.png",
                          width: 75,
                          height: 75,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Transform.translate(
              offset: Offset(0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/icon.png"),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        "التصحيح",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.7,
                          height: 100,
                          padding: EdgeInsets.only(
                              left: 35, bottom: 30, right: 30, top: 20),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("Assets/orangebox.png"),
                                opacity: 0.8,
                                fit: BoxFit.fill),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xffedf2d7),
                            ),
                            child: buildStyledText(recivedmessage!),
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                            -MediaQuery.of(context).size.width / 1.8, 15),
                        child: InkWell(
                            onTap: () {
                              speak.speakText(recivedmessage!);
                            },
                            child: Image.asset(
                              "Assets/listen.png",
                              width: 75,
                              height: 75,
                            )),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
