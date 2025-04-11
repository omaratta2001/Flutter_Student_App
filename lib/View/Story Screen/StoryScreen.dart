import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/GeneratingImage.dart';
import 'package:student_app/Controller/OpenAIController.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:student_app/View/Story%20Screen/GeneratingScreen.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class Storyscreen extends StatefulWidget {
  const Storyscreen({super.key});

  @override
  State<Storyscreen> createState() => _StoryscreenState();
}

class _StoryscreenState extends State<Storyscreen> {
  SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String _spokenTextCar = '';
  String _spokenTextPlace = '';
  String _spokenTextCount = '';
  String _spokenTextTime = '';
  String _spokenTextIdea = '';

  TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speechService.initSpeech();
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
                        SpeechService _speechService = SpeechService();
                        bool _isListening = false;
                        String _spokenTextCar = '';
                        String _spokenTextPlace = '';
                        String _spokenTextCount = '';
                        String _spokenTextTime = '';
                        String _spokenTextIdea = '';

                        TextEditingController _queryController =
                            TextEditingController();
                        setState(() {});
                      },
                      child: Image.asset(
                        "Assets/Delete_.png",
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
                    SizedBox(
                      width: 10,
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
                "Assets/story.png",
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
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                SizedBox(
                  height: 90,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "Assets/typeOfcharacter.png",
                        width: MediaQuery.of(context).size.width / 7,
                        fit: BoxFit.contain,
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                decoration: BoxDecoration(
                                  color: Color(0xFFfca21c),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, bottom: 8, right: 30),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    padding:
                                        EdgeInsets.only(right: 18, top: 22),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      _spokenTextCar,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(
                                MediaQuery.of(context).size.width / 25, 5),
                            child: InkWell(
                                onTap: () async {
                                  if (!_isListening) {
                                    setState(() => _isListening = true);
                                    await _speechService.startListening((text) {
                                      setState(() {
                                        _spokenTextCar = text;
                                        _queryController.text = text;
                                      });
                                    });
                                  } else {
                                    _speechService.stopListening();
                                    setState(() {
                                      _isListening = false;
                                    });
                                  }
                                },
                                child: Image.asset(
                                  "Assets/Mic.png",
                                  width: MediaQuery.of(context).size.width / 10,
                                  height:
                                      MediaQuery.of(context).size.height / 6,
                                  fit: BoxFit.contain,
                                )),
                          )
                        ],
                      ),
                      Image.asset(
                        "Assets/place.png",
                        width: MediaQuery.of(context).size.width / 7,
                        fit: BoxFit.contain,
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                decoration: BoxDecoration(
                                  color: Color(0xFFfca21c),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, bottom: 8, right: 30),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding:
                                        EdgeInsets.only(right: 18, top: 22),
                                    child: Text(
                                      _spokenTextPlace,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(
                                MediaQuery.of(context).size.width / 25, 5),
                            child: InkWell(
                              onTap: () async {
                                if (!_isListening) {
                                  setState(() => _isListening = true);
                                  await _speechService.startListening((text) {
                                    setState(() {
                                      _spokenTextPlace = text;
                                      _queryController.text = text;
                                    });
                                  });
                                } else {
                                  _speechService.stopListening();
                                  setState(() {
                                    _isListening = false;
                                  });
                                }
                              },
                              child: Image.asset(
                                "Assets/Mic.png",
                                width: MediaQuery.of(context).size.width / 10,
                                height: MediaQuery.of(context).size.height / 6,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "Assets/countforperson.png",
                        width: MediaQuery.of(context).size.width / 7,
                        fit: BoxFit.contain,
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                decoration: BoxDecoration(
                                  color: Color(0xFFfca21c),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, bottom: 8, right: 30),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding:
                                        EdgeInsets.only(right: 18, top: 22),
                                    child: Text(
                                      _spokenTextCount,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(
                                MediaQuery.of(context).size.width / 25, 5),
                            child: InkWell(
                              onTap: () async {
                                if (!_isListening) {
                                  setState(() => _isListening = true);
                                  await _speechService.startListening((text) {
                                    setState(() {
                                      _spokenTextCount = text;
                                      _queryController.text = text;
                                    });
                                  });
                                } else {
                                  _speechService.stopListening();
                                  setState(() {
                                    _isListening = false;
                                  });
                                }
                              },
                              child: Image.asset(
                                "Assets/Mic.png",
                                width: MediaQuery.of(context).size.width / 10,
                                height: MediaQuery.of(context).size.height / 6,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        ],
                      ),
                      Image.asset(
                        "Assets/time.png",
                        width: MediaQuery.of(context).size.width / 7,
                        fit: BoxFit.contain,
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                                decoration: BoxDecoration(
                                  color: Color(0xFFfca21c),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 8, bottom: 8, right: 30),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding:
                                        EdgeInsets.only(right: 18, top: 22),
                                    child: Text(
                                      _spokenTextTime,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Transform.translate(
                            offset: Offset(
                                MediaQuery.of(context).size.width / 25, 5),
                            child: InkWell(
                              onTap: () async {
                                if (!_isListening) {
                                  setState(() => _isListening = true);
                                  await _speechService.startListening((text) {
                                    setState(() {
                                      _spokenTextTime = text;
                                      _queryController.text = text;
                                    });
                                  });
                                } else {
                                  _speechService.stopListening();
                                  setState(() {
                                    _isListening = false;
                                  });
                                }
                              },
                              child: Image.asset(
                                "Assets/Mic.png",
                                width: MediaQuery.of(context).size.width / 10,
                                height: MediaQuery.of(context).size.height / 6,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("Assets/Layer43.png"),
                                fit: BoxFit.fill),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "سجل فكرة",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.6,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFfca21c),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0,
                                          top: 8,
                                          bottom: 8,
                                          right: 30),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        padding:
                                            EdgeInsets.only(right: 22, top: 20),
                                        child: Text(
                                          _spokenTextIdea,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Transform.translate(
                                offset: Offset(
                                    MediaQuery.of(context).size.width / 40, 0),
                                child: InkWell(
                                  onTap: () async {
                                    if (!_isListening) {
                                      setState(() => _isListening = true);
                                      await _speechService
                                          .startListening((text) {
                                        setState(() {
                                          _spokenTextIdea = text;
                                          _queryController.text = text;
                                        });
                                      });
                                    } else {
                                      _speechService.stopListening();
                                      setState(() {
                                        _isListening = false;
                                      });
                                    }
                                  },
                                  child: Image.asset(
                                    "Assets/Mic.png",
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: InkWell(
                            onTap: () async {
                              final imageService = ImageGenerationService(
                                apiKey:
                                    'sk-8O39BNVMc5JJf9ppRs2456ieucZtT3wzBgbGQ67zYj5ZfhPJ',
                                imageAIStyle: ImageAIStyle
                                    .digitalPainting, // optional style
                              );
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              String? age = await prefs.getString('age');
                              String? boy = await prefs.getString('Isboy');
                              String prompit = 'أنا ' +
                                  boy! +
                                  '، عمري ' +
                                  age! +
                                  ' سنوات،' +
                                  '، اريدك ان تكتب قصة، ضع عنوان مناسب للقصة، اكتب القصة بشكل متسلسل بها بداية ووسط ونهاية، راعي ان تكون الحبكة مناسبة لسني، وطول القصة مناسب لسني، راعي الكتابة باللغة العربية الفصحى المبسطة ';
                              if (_spokenTextCar != '') {
                                prompit = prompit +
                                    'راعي ان يكون نوع الشخصيات ' +
                                    _spokenTextCar!;
                              }
                              if (_spokenTextPlace != '') {
                                prompit = prompit +
                                    'راعي ان يكون المكان ' +
                                    _spokenTextPlace!;
                              }
                              if (_spokenTextCount != '') {
                                prompit = prompit +
                                    'راعي ان يكون عدد الشخصيات ' +
                                    _spokenTextCount!;
                              }
                              if (_spokenTextTime != '') {
                                prompit = prompit +
                                    'راعي ان يكون الزمن ' +
                                    _spokenTextTime!;
                              }
                              if (_spokenTextIdea != '') {
                                prompit = prompit +
                                    'راعي ان تكون فكرة القصة عن ' +
                                    _spokenTextIdea!;
                              }

                              String? gentext = '';
                              //await OpenAIService.sendRequest(
                              //     prompit +
                              //         ' translate this to english without saying anything before or after only say the translation');
                              GeminiTextService _gemin =
                                  new GeminiTextService();
                              gentext = await _gemin.generateText(prompit +
                                  ' translate this to english without saying anything before or after only say the translation');

                              print(prompit);
                              print(gentext);

                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return Generatingscreen(
                                  prompt: prompit,
                                );
                              }));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 12,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "Assets/Search.png",
                                    ),
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
