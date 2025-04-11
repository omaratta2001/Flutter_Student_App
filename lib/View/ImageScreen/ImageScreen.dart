import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/Controller/GeneratingImage.dart';
import 'package:student_app/Controller/OpenAIController.dart';
import 'package:student_app/Model/AdvClass.dart';
import 'package:student_app/Model/ChooseStyle.dart';
import 'package:student_app/View/ImageScreen/Land1Screen.dart';
import 'package:student_app/View/ImageScreen/PortraitScreen.dart';
import 'package:student_app/View/ImageScreen/landScreen.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

import '../../Controller/SpeakToText.dart';

class Imagescreen extends StatefulWidget {
  const Imagescreen({super.key});

  @override
  State<Imagescreen> createState() => _ImagescreenState();
}

class _ImagescreenState extends State<Imagescreen> {
  List<bool> numberBoxSelections = List.generate(7, (index) => false);
  List<bool> selectedscale = List.generate(3, (index) => false);
  SpeechService _speechService = SpeechService();
  bool _isListening = false;
  late ImageAIStyle imageAIStyle;

  String _spokenText = '';

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
        title: Center(
          child: Transform.translate(
            offset: Offset(-30, -10),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  height: 80,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xff9abce1).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Transform.translate(
                        offset: Offset(30, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("Assets/icon.png"),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                "صورة عن",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.4,
                                height: 50,
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
                                        EdgeInsets.only(right: 18, top: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      _spokenText,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            child: InkWell(
                              onTap: () async {
                                if (!_isListening) {
                                  setState(() => _isListening = true);
                                  await _speechService.startListening((text) {
                                    setState(() {
                                      _spokenText = text;
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
                              child: Transform.translate(
                                offset: Offset(0, 3),
                                child: Image.asset(
                                  "Assets/Mic.png",
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Transform.translate(
              offset: Offset(-20, -20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      List<bool> numberBoxSelections =
                          List.generate(7, (index) => false);
                      List<bool> selectedscale =
                          List.generate(3, (index) => false);
                      SpeechService _speechService = SpeechService();
                      bool _isListening = false;
                      late ImageAIStyle imageAIStyle;

                      String _spokenText = '';

                      TextEditingController _queryController =
                          TextEditingController();
                    },
                    child: Image.asset(
                      "Assets/Delete.png",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "Assets/Layer9.png",
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
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Stack(
                //   children: [
                //     Container(
                //       width: MediaQuery.of(context).size.width / 2.4,
                //       height: 80,
                //       padding: EdgeInsets.all(10),
                //       decoration: BoxDecoration(
                //           color: Color(0xff9abce1).withOpacity(0.5),
                //           borderRadius: BorderRadius.circular(15)),
                //       child: Row(
                //         children: [
                //           Transform.translate(
                //             offset: Offset(30, 0),
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 image: DecorationImage(
                //                   image: AssetImage("Assets/icon.png"),
                //                 ),
                //               ),
                //               child: Padding(
                //                 padding: const EdgeInsets.all(8),
                //                 child: Center(
                //                   child: Text(
                //                     "صورة عن",
                //                     style: TextStyle(
                //                         fontSize: 20,
                //                         color: Colors.white,
                //                         fontWeight: FontWeight.bold),
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //           Stack(
                //             children: [
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Container(
                //                     width:
                //                         MediaQuery.of(context).size.width / 3.4,
                //                     height: 50,
                //                     decoration: BoxDecoration(
                //                       color: Color(0xFFfca21c),
                //                       borderRadius: BorderRadius.circular(15),
                //                     ),
                //                     child: Padding(
                //                       padding: const EdgeInsets.only(
                //                           left: 8.0,
                //                           top: 8,
                //                           bottom: 8,
                //                           right: 30),
                //                       child: Container(
                //                         width:
                //                             MediaQuery.of(context).size.width,
                //                         height:
                //                             MediaQuery.of(context).size.height,
                //                         padding:
                //                             EdgeInsets.only(right: 18, top: 7),
                //                         decoration: BoxDecoration(
                //                             color: Colors.white,
                //                             borderRadius:
                //                                 BorderRadius.circular(15)),
                //                         child: Text(
                //                           _spokenText,
                //                           style: TextStyle(fontSize: 15),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //               Positioned(
                //                 child: InkWell(
                //                   onTap: () async {
                //                     if (!_isListening) {
                //                       setState(() => _isListening = true);
                //                       await _speechService
                //                           .startListening((text) {
                //                         setState(() {
                //                           _spokenText = text;
                //                           _queryController.text = text;
                //                         });
                //                       });
                //                     } else {
                //                       _speechService.stopListening();
                //                       setState(() {
                //                         _isListening = false;
                //                       });
                //                     }
                //                   },
                //                   child: Transform.translate(
                //                     offset: Offset(0, 3),
                //                     child: Image.asset(
                //                       "Assets/Mic.png",
                //                       width: 45,
                //                       height: 45,
                //                     ),
                //                   ),
                //                 ),
                //               )
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 80,
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.15,
                      height: 100,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color(0xff9abce1).withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Transform.translate(
                            offset: Offset(30, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("Assets/icon.png"),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Text(
                                    "نمط الرسم",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageAIStyle = ImageAIStyle.cartoon;
                                numberBoxSelections =
                                    List.generate(7, (index) => false);
                                numberBoxSelections[0] = true;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: numberBoxSelections[0]
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                            color: Colors.green, width: 4))
                                    : null,
                                child: Image.asset(
                                  "Assets/Icon/1.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageAIStyle = ImageAIStyle.render3D;

                                numberBoxSelections =
                                    List.generate(7, (index) => false);
                                numberBoxSelections[1] = true;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: numberBoxSelections[1]
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                            color: Colors.green, width: 4))
                                    : null,
                                child: Image.asset(
                                  "Assets/Icon/2.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageAIStyle = ImageAIStyle.moreDetails;

                                numberBoxSelections =
                                    List.generate(7, (index) => false);
                                numberBoxSelections[2] = true;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: numberBoxSelections[2]
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                            color: Colors.green, width: 4))
                                    : null,
                                child: Image.asset(
                                  "Assets/Icon/3.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageAIStyle = ImageAIStyle.digitalPainting;

                                numberBoxSelections =
                                    List.generate(7, (index) => false);
                                numberBoxSelections[3] = true;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: numberBoxSelections[3]
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                            color: Colors.green, width: 4))
                                    : null,
                                child: Image.asset(
                                  "Assets/Icon/4.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageAIStyle = ImageAIStyle.pencilDrawing;

                                numberBoxSelections =
                                    List.generate(7, (index) => false);
                                numberBoxSelections[4] = true;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: numberBoxSelections[4]
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                            color: Colors.green, width: 4))
                                    : null,
                                child: Image.asset(
                                  "Assets/Icon/5.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageAIStyle = ImageAIStyle.studioPhoto;

                                numberBoxSelections =
                                    List.generate(7, (index) => false);
                                numberBoxSelections[5] = true;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: numberBoxSelections[5]
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                            color: Colors.green, width: 4))
                                    : null,
                                child: Image.asset(
                                  "Assets/Icon/6.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                imageAIStyle = ImageAIStyle.goncharovaPainter;

                                numberBoxSelections =
                                    List.generate(7, (index) => false);
                                numberBoxSelections[6] = true;
                              });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                decoration: numberBoxSelections[6]
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.circular(23),
                                        border: Border.all(
                                            color: Colors.green, width: 4))
                                    : null,
                                child: Image.asset(
                                  "Assets/Icon/7.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff9abce1).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Transform.translate(
                              offset: Offset(30, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("Assets/icon.png"),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Text(
                                      "الحجم",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedscale =
                                      List.generate(3, (index) => false);
                                  selectedscale[0] = true;
                                });
                              },
                              child: ClipRRect(
                                child: Container(
                                  decoration: selectedscale[0]
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          border: Border.all(
                                              color: Colors.green, width: 4))
                                      : null,
                                  child: Image.asset(
                                    "Assets/Icon/land.png",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              // child: Image.asset(
                              //   "Assets/Icon/land.png",
                              //   width: 80,
                              //   height: 80,
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedscale =
                                      List.generate(3, (index) => false);
                                  selectedscale[1] = true;
                                });
                              },
                              child: ClipRRect(
                                child: Container(
                                  decoration: selectedscale[1]
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                              color: Colors.green, width: 4))
                                      : null,
                                  child: Image.asset(
                                    "Assets/Icon/land1.png",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  selectedscale =
                                      List.generate(3, (index) => false);
                                  selectedscale[2] = true;
                                });
                              },
                              child: ClipRRect(
                                child: Container(
                                  decoration: selectedscale[2]
                                      ? BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(23),
                                          border: Border.all(
                                              color: Colors.green, width: 4))
                                      : null,
                                  child: Image.asset(
                                    "Assets/Icon/portrait.png",
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          final imageService = ImageGenerationService(
                            apiKey:
                                'sk-fzuK30CcYxm7LN7ZdZjHtZGbt7c9czTietIicFUC1QYJ3vMt',
                            imageAIStyle:
                                ImageAIStyle.studioPhoto, // optional style
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
                              ' اريدك ان ترسم لي صورة، ملونة، وجميلة، ومعبرة جدا ' +
                              'راعي ان تكون الصورة عن ' +
                              _spokenText;
                          String gentext = await OpenAIService.sendRequest(prompit +
                              ' translate this to english without saying anything before or after only say the translation');

                          print(prompit);
                          print(gentext);
                          if (selectedscale[0]) {
                            // final imageBytes = await imageService.generateImage(
                            //     'A beautiful sunset over mountains');

                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Landscreen(
                                prompt: gentext,
                                imageAIStyle: imageAIStyle,
                              );
                            }));
                          } else if (selectedscale[2]) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Land1screen(
                                prompt: gentext,
                              );
                            }));
                          } else if (selectedscale[1]) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return Portraitscreen(
                                prompt: gentext,
                                imageAIStyle: imageAIStyle,
                              );
                            }));
                          }
                        },
                        child: Image.asset(
                          "Assets/Search.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
