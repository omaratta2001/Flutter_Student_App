import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/Controller/GeminiService.dart';
import 'package:student_app/Controller/OpenAIController.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:student_app/View/Paint%20Screen/PaintlandScreen.dart';
import 'package:student_app/Widget/MicButton.dart';

class Paintscreen extends StatefulWidget {
  const Paintscreen({super.key});

  @override
  State<Paintscreen> createState() => _PaintscreenState();
}

class _PaintscreenState extends State<Paintscreen> {
  final SpeechService _speechService = SpeechService();
  String recivedmessage = '';
  bool _isListening = false;
  String _spokenText = '';

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
                  Image.asset(
                    "Assets/Regenerate.png",
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
              "Assets/colorbook.png",
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 5.5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("Assets/icon.png"),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        "وصف الصورة",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                        color: Color(0xFFfca21c),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8, bottom: 8, right: 30),
                        child: Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            padding: EdgeInsets.only(right: 60, top: 45),
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

                          String? age = await prefs.getString('age');
                          String? boy = await prefs.getString('Isboy');
                          String prompit = 'أنا ' +
                              boy! +
                              '، عمري ' +
                              age! +
                              ' سنوات،' +
                              '، اريد صورة مبسطة للتلوين بالأبيض والأسود، لكي أقوم بطباعتها وتلوينها، الصورة عن ' +
                              _spokenText;
                          GeminiTextService _gemin = new GeminiTextService();

                          String? gentext = await _gemin.generateText(prompit +
                              ' translate this to english without saying anything before or after only say the translation');
                          print(gentext);
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Paintlandscreen(prompt: gentext!);
                          }));
                          //   recivedmessage = await OpenAIService.sendRequest(
                          //     "how are you doing ?");
                          // print(recivedmessage);
                          // setState(() {
                          //   recivedmessage = recivedmessage;
                          // });
                        },
                        child: Image.asset(
                          "Assets/Search.png",
                          width: MediaQuery.of(context).size.width / 11,
                        ),
                      ),
                    )
                  ],
                ),
                Center(
                  child: Transform.translate(
                    offset: Offset(MediaQuery.of(context).size.width / 3.6,
                        MediaQuery.of(context).size.height / 22),
                    child: InkWell(
                      onTap: () async {
                        if (!_isListening) {
                          setState(() => _isListening = true);
                          await _speechService.startListening((text) {
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
                      child: Image.asset(
                        "Assets/Mic.png",
                        width: MediaQuery.of(context).size.width / 7,
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                    ),
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
