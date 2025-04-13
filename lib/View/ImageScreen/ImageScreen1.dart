import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:student_app/View/ImageScreen/Land1Screen.dart';
import 'package:student_app/View/ImageScreen/PortraitScreen.dart';
import 'package:student_app/View/ImageScreen/landScreen.dart';

class Imagescreen1 extends StatefulWidget {
  const Imagescreen1({super.key});

  @override
  State<Imagescreen1> createState() => _Imagescreen1State();
}

class _Imagescreen1State extends State<Imagescreen1> {
  List<bool> numberBoxSelections = List.generate(7, (index) => false);
  List<bool> selectedscale = List.generate(3, (index) => false);
  SpeechService _speechService = SpeechService();
  bool _isListening = false;
  late ImageAIStyle imageAIStyle;
  String style = '';
  String _spokenText = '';

  @override
  void initState() {
    super.initState();
    _speechService.initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.translate(
              offset: Offset(0, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset(
                      "Assets/image.png",
                      width: MediaQuery.of(context).size.width / 10,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: MediaQuery.of(context).size.height / 5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff9abce1).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Expanded(
                              child: Transform.translate(
                                offset: Offset(45, 0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage("Assets/icon.png"),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: Flexible(
                                        child: Text(
                                          "صورة عن",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
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
                                      width: MediaQuery.of(context).size.width /
                                          3.4,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
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
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          padding: EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  22,
                                              top: 10),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text(
                                            _spokenText,
                                            style: TextStyle(fontSize: 20),
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
                                        await _speechService
                                            .startListening((text) {
                                          setState(() {
                                            _spokenText = text;
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
                                      offset: Offset(20, 0),
                                      child: Image.asset(
                                        "Assets/Mic.png",
                                        width:
                                            MediaQuery.of(context).size.width /
                                                12,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        fit: BoxFit.contain,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            numberBoxSelections =
                                List.generate(7, (index) => false);
                            selectedscale = List.generate(3, (index) => false);
                            _speechService = SpeechService();
                            _isListening = false;
                            style = '';
                            _spokenText = '';

                            setState(() {});
                          },
                          child: Image.asset(
                            "Assets/Delete.png",
                            width: MediaQuery.of(context).size.width / 13,
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
                            width: MediaQuery.of(context).size.width / 13,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.15,
                        height: MediaQuery.of(context).size.height / 3.5,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff9abce1).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  padding: const EdgeInsets.all(12),
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
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageAIStyle = ImageAIStyle.cartoon;
                                    style = ', 2d cartoon';
                                    numberBoxSelections =
                                        List.generate(7, (index) => false);
                                    numberBoxSelections[0] = true;
                                  });
                                },
                                child: Container(
                                  decoration: numberBoxSelections[0]
                                      ? BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.green, width: 4))
                                      : null,
                                  child: Image.asset(
                                    "Assets/Icon/1.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageAIStyle = ImageAIStyle.render3D;
                                    style = ', 3d cartoon';

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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.green, width: 4))
                                        : null,
                                    child: Image.asset(
                                      "Assets/Icon/2.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageAIStyle = ImageAIStyle.moreDetails;
                                    style = ', Realistic';

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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.green, width: 4))
                                        : null,
                                    child: Image.asset(
                                      "Assets/Icon/3.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageAIStyle = ImageAIStyle.digitalPainting;
                                    style = ', mosaic';
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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.green, width: 4))
                                        : null,
                                    child: Image.asset(
                                      "Assets/Icon/4.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageAIStyle = ImageAIStyle.pencilDrawing;
                                    style = ', pencil sketch';
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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.green, width: 4))
                                        : null,
                                    child: Image.asset(
                                      "Assets/Icon/5.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageAIStyle = ImageAIStyle.studioPhoto;
                                    style = ' بتصميم, Sculpture';
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
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                                color: Colors.green, width: 4))
                                        : null,
                                    child: Image.asset(
                                      "Assets/Icon/6.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    imageAIStyle =
                                        ImageAIStyle.goncharovaPainter;
                                    style = ', Claymation';
                                    numberBoxSelections =
                                        List.generate(7, (index) => false);
                                    numberBoxSelections[6] = true;
                                  });
                                },
                                child: Container(
                                  decoration: numberBoxSelections[6]
                                      ? BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.green, width: 4))
                                      : null,
                                  child: Image.asset(
                                    "Assets/Icon/7.png",
                                    fit: BoxFit.contain,
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
                          height: MediaQuery.of(context).size.height / 3.5,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xff9abce1).withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: Transform.translate(
                                  offset: Offset(
                                      MediaQuery.of(context).size.width / 19,
                                      0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    width:
                                        MediaQuery.of(context).size.width / 12,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage("Assets/icon.png"),
                                          fit: BoxFit.fill),
                                    ),
                                    child: Center(
                                      child: Expanded(
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
                              ),
                              Expanded(
                                child: InkWell(
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
                                                  color: Colors.green,
                                                  width: 4))
                                          : null,
                                      child: Image.asset(
                                        "Assets/Icon/land.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
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
                                                  color: Colors.green,
                                                  width: 4))
                                          : null,
                                      child: Expanded(
                                        child: Image.asset(
                                          "Assets/Icon/land1.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: InkWell(
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
                                                  color: Colors.green,
                                                  width: 4))
                                          : null,
                                      child: Expanded(
                                        child: Image.asset(
                                          "Assets/Icon/portrait.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? age = await prefs.getString('age');
                            String? boy = await prefs.getString('Isboy');
                            String prompit =
                                'أنا ${boy!}، عمري ${age!} سنوات، اريدك ان ترسم لي صورة، ملونة، وجميلة، ومعبرة جدا راعي ان تكون الصورة عن $_spokenText$style';
                            GeminiTextService _gemin = new GeminiTextService();

                            String? gentext = await _gemin.generateText(
                                '$prompit translate this to english without saying anything before or after only say the translation');

                            print(prompit);
                            print(gentext);
                            for (int i = 0;
                                i < numberBoxSelections.length;
                                i++) {
                              if (numberBoxSelections[i]) {
                                if (selectedscale[0]) {
                                  // final imageBytes = await imageService.generateImage(
                                  //     'A beautiful sunset over mountains');

                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return Landscreen(
                                      prompt: gentext!,
                                      imageAIStyle: imageAIStyle,
                                    );
                                  }));
                                } else if (selectedscale[2]) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return Land1screen(
                                      prompt: gentext!,
                                    );
                                  }));
                                } else if (selectedscale[1]) {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return Portraitscreen(
                                      prompt: gentext!,
                                      imageAIStyle: imageAIStyle,
                                    );
                                  }));
                                }
                              }
                            }
                          },
                          child: Image.asset(
                            "Assets/Search.png",
                            width: MediaQuery.of(context).size.width / 12,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
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
