// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';
// ignore: depend_on_referenced_packages
import 'package:flutter/services.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

import 'package:flutter/material.dart';
import 'package:student_app/Controller/FlutterTTS.dart';
import 'package:student_app/Controller/GeminiImage.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/GeneratingImage.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:student_app/Controller/spans.dart';

class Generatingtext extends StatefulWidget {
  final String prompt;

  const Generatingtext({
    required this.prompt,
  });

  @override
  State<Generatingtext> createState() => _GeneratingtextState();
}

class _GeneratingtextState extends State<Generatingtext> {
  TTSService speak = TTSService();

  late Future<void> genai;
  String genais = '';
  String titlename = '';
  bool _isGeneratingtext = true;
  String? gentext = '';

  SpeechService _speechService = SpeechService();
  String? recivedmessage = '';
  bool _isListening = false;
  String _spokenText = '';
  @override
  void initState() {
    super.initState();
    // Start generating image immediately when screen loads
    genai = _generatetext();
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
  }

  Future<void> _generatetext() async {
    try {
      GeminiTextService _gemin = new GeminiTextService();

      final textss = await _gemin.generateText(widget.prompt);
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
            padding: const EdgeInsets.all(25),
            child: Transform.translate(
              offset: Offset(-20, -20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isGeneratingtext = true;
                      });
                      genai = _generatetext();
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
                  )
                ],
              ),
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.all(15),
          child: Transform.translate(
            offset: Offset(-10, -15),
            child: Image.asset(
              "Assets/image.png",
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
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 1,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("Assets/Greenbox.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.12,
                            right: 20,
                            left: 20,
                            top: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xffedf2d7),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.058,
                                right: 20,
                                left: 20,
                                top: 20),
                            child: InkWell(
                              onLongPress: () {
                                _copyToClipboard(genais);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffedf2d7),
                                ),
                                padding: EdgeInsets.all(5),
                                child: _isGeneratingtext
                                    ? Center(child: CircularProgressIndicator())
                                    : SingleChildScrollView(
                                        child: Center(
                                            child:
                                                buildStyledText(genais, 20))),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.08,
                    right: MediaQuery.of(context).size.width / 1.7,
                    width: 70,
                    height: 70,
                    child: InkWell(
                        onTap: () async {
                          await speak.speakText(genais);
                        },
                        child: Image.asset("Assets/listen.png")),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
