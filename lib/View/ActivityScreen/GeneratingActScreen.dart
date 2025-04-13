// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/Controller/FlutterTTS.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/Providers/GeneratingActScreen_provider.dart';
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
        scrolledUnderElevation: 0,
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
                  Consumer<generatingactscreenprovider>(
                    builder: (BuildContext context, provider, Widget? child) {
                      return InkWell(
                        onTap: () {
                          provider.regenrate();
                        },
                        child: Image.asset(
                          "Assets/Regenerate.png",
                        ),
                      );
                    },
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
        leading: Container(),
        // leading: Padding(
        //   padding: const EdgeInsets.all(15),
        //   child: Transform.translate(
        //     offset: Offset(-37, -15),
        //     child: Image.asset(
        //       "Assets/activity.png",
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
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
                          child: Consumer<generatingactscreenprovider>(
                            builder: (BuildContext context, provider,
                                Widget? child) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffedf2d7),
                                ),
                                child: provider.isGeneratingtext
                                    ? Center(child: CircularProgressIndicator())
                                    : SingleChildScrollView(
                                        child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: buildStyledText(
                                            provider.genais, 15),
                                      )),
                              );
                            },
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
                      child: Consumer<generatingactscreenprovider>(
                        builder:
                            (BuildContext context, provider, Widget? child) {
                          return InkWell(
                              onTap: () {
                                provider.speaktext();
                              },
                              child: Image.asset(
                                "Assets/listen.png",
                                width: 75,
                                height: 75,
                              ));
                        },
                      ),
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
                          child: Consumer<generatingactscreenprovider>(
                            builder: (BuildContext context, provider,
                                Widget? child) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffedf2d7),
                                ),
                                child: buildStyledText(provider.spokenText, 15),
                              );
                            },
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
                      child: Consumer<generatingactscreenprovider>(
                        builder:
                            (BuildContext context, provider, Widget? child) {
                          return InkWell(
                            onTap: () async {
                              await provider.toggleListening();
                            },
                            child: Image.asset(
                              "Assets/Mic.png",
                              width: 75,
                              height: 75,
                            ),
                          );
                        },
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
                          child: Consumer<generatingactscreenprovider>(
                            builder: (BuildContext context, provider,
                                Widget? child) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0xffedf2d7),
                                ),
                                child: SingleChildScrollView(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: provider.isgenerating
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : buildStyledText(
                                          provider.recivedmessage!, 15),
                                )),
                              );
                            },
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(
                            -MediaQuery.of(context).size.width / 1.8, 15),
                        child: Consumer<generatingactscreenprovider>(
                          builder:
                              (BuildContext context, provider, Widget? child) {
                            return provider.isanswer
                                ? InkWell(
                                    onTap: () {
                                      provider.speakanswer();
                                    },
                                    child: Image.asset(
                                      "Assets/listen.png",
                                      width: 75,
                                      height: 75,
                                    ))
                                : InkWell(
                                    onTap: () {
                                      provider.generateanser();
                                    },
                                    child: Image.asset(
                                      "Assets/Search.png",
                                      width: 75,
                                      height: 75,
                                    ));
                          },
                        ),
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
