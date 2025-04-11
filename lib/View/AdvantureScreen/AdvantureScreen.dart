import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:student_app/Model/AdvClass.dart';
import 'package:student_app/View/AdvantureScreen/GeneratingAdvScreen.dart';

class Advanturescreen extends StatefulWidget {
  const Advanturescreen({super.key});

  @override
  State<Advanturescreen> createState() => _AdvanturescreenState();
}

class _AdvanturescreenState extends State<Advanturescreen> {
  SpeechService _speechService = SpeechService();
  bool _isListening = false;
  String _spokenText = '';

  TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _speechService.initSpeech();
  }

  String adv = '';
  List<Advclass> selection = [
    Advclass(name: 'space'),
    Advclass(name: 'sea'),
    Advclass(name: 'pyramids'),
    Advclass(name: 'southantertaica'),
    Advclass(name: 'mountain'),
  ];
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
                      _speechService = SpeechService();
                      _isListening = false;
                      _spokenText = '';
                      selection.forEach((x) => x.isActive = false);
                      _queryController = TextEditingController();
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
              "Assets/Advantare.png",
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/icon.png"),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Center(
                        child: Text(
                          "مغامرة في",
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
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            // numberBoxSelections =
                            //     List.generate(5, (index) => false);
                            // numberBoxSelections[0] = true;
                            adv = 'الفضاء';
                            selection.forEach((x) => x.isActive = false);
                            selection[0].isActive = true;
                          });
                        },
                        child: Container(
                          decoration: selection[0].isActive
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border:
                                      Border.all(color: Colors.green, width: 4))
                              : null,
                          child: Image.asset(
                            "Assets/Icon/Space.png",
                            width: MediaQuery.of(context).size.width / 7,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            adv = 'أعماق البحار';

                            selection.forEach((x) => x.isActive = false);
                            selection[1].isActive = true;
                          });
                        },
                        child: Container(
                          decoration: selection[1].isActive
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border:
                                      Border.all(color: Colors.green, width: 4))
                              : null,
                          child: Image.asset(
                            "Assets/Icon/sea.png",
                            width: MediaQuery.of(context).size.width / 7,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            adv = 'الأهرامات';
                            selection.forEach((x) => x.isActive = false);
                            selection[2].isActive = true;
                          });
                        },
                        child: Container(
                          decoration: selection[2].isActive
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border:
                                      Border.all(color: Colors.green, width: 4))
                              : null,
                          child: Image.asset(
                            "Assets/Icon/pyramids.png",
                            width: MediaQuery.of(context).size.width / 7,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            adv = 'القطب الشمالي';
                            selection.forEach((x) => x.isActive = false);
                            selection[3].isActive = true;
                          });
                        },
                        child: Container(
                          decoration: selection[3].isActive
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border:
                                      Border.all(color: Colors.green, width: 6))
                              : null,
                          child: Image.asset(
                            "Assets/Icon/southantertaica.png",
                            width: MediaQuery.of(context).size.width / 7,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            adv = 'جبال افرست';
                            selection.forEach((x) => x.isActive = false);
                            selection[4].isActive = true;
                          });
                        },
                        child: Container(
                          decoration: selection[4].isActive
                              ? BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  border:
                                      Border.all(color: Colors.green, width: 4))
                              : null,
                          child: Image.asset(
                            "Assets/Icon/mountain.png",
                            width: MediaQuery.of(context).size.width / 7,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                    //   Image.asset(
                    //     "Assets/Icon/sea.png",
                    //     width: 120,
                    //     height: 120,
                    //     fit: BoxFit.contain,
                    //   ),
                    //   Image.asset(
                    //     "Assets/Icon/pyramids.png",
                    //     width: 120,
                    //     height: 120,
                    //     fit: BoxFit.contain,
                    //   ),
                    //   Image.asset(
                    //     "Assets/Icon/southantertaica.png",
                    //     width: 120,
                    //     height: 120,
                    //     fit: BoxFit.contain,
                    //   ),
                    //   Image.asset(
                    //     "Assets/Icon/mountain.png",
                    //     width: 120,
                    //     height: 120,
                    //     fit: BoxFit.contain,
                    //   ),
                    // ],
                  ),
                )),
              ],
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("Assets/icon.png"),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        "مغامرة أخرى",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFfca21c),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Expanded(
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
                                            EdgeInsets.only(right: 40, top: 20),
                                        child: Text(
                                          _spokenText,
                                          style: TextStyle(fontSize: 25),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: InkWell(
                                    onTap: () async {
                                      final SharedPreferences prefs =
                                          await SharedPreferences.getInstance();

                                      String? age =
                                          await prefs.getString('age');
                                      String? boy =
                                          await prefs.getString('Isboy');
                                      String prompit = 'أنا ' +
                                          boy! +
                                          '، عمري ' +
                                          age! +
                                          ' سنوات،' +
                                          ' اكتب لي مغامرة قصيرة موجهة، بلغة عربية فصحى مبسطة جدًا، وبأسلوب وصف مباشر وليس على شكل قصة. لا أريد وجود شخصيات أو حوار أو تسلسل أحداث. فقط أريد وصفًا مباشرًا لتجربة خيالية يشعر الطفل أنه يعيشها، وكأنها مغامرة سريعة يقرأها ويتخيل نفسه بداخلها. يجب أن يكون النص في حدود 100 كلمة، وأفكار تناسب سن الطفل، ';
                                      if (_spokenText != '') {
                                        prompit = prompit +
                                            'راعي ان تكون المغامرة عن ' +
                                            _spokenText;
                                      } else {
                                        prompit = prompit +
                                            'راعي ان تكون المغامرة عن ' +
                                            adv;
                                      }
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return Generatingadvscreen(
                                          prompt: prompit,
                                        );
                                      }));
                                    },
                                    child: Image.asset(
                                      "Assets/Search.png",
                                      width: MediaQuery.of(context).size.width /
                                          15,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Transform.translate(
                              offset: Offset(
                                  MediaQuery.of(context).size.width / 30, 10),
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
                                child: Expanded(
                                  child: Image.asset(
                                    "Assets/Mic.png",
                                    width:
                                        MediaQuery.of(context).size.width / 10,
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
