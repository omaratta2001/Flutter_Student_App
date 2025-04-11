import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/Controller/Providers/SelectCategories_provider.dart';
import 'package:student_app/Controller/SpeakToText.dart';
import 'package:student_app/View/ActivityScreen/ActivityScreen.dart';
import 'package:student_app/View/AdvantureScreen/AdvantureScreen.dart';
import 'package:student_app/View/ImageScreen/ImageScreen1.dart';
import 'package:student_app/View/Paint%20Screen/PaintScreen.dart';
import 'package:student_app/View/Story%20Screen/StoryScreen.dart';
import 'package:student_app/Widget/IconWidget.dart';

class SelectionCategory extends StatefulWidget {
  const SelectionCategory({super.key});

  @override
  State<SelectionCategory> createState() => _SelectionCategoryState();
}

class _SelectionCategoryState extends State<SelectionCategory> {
  // final SpeechService _speechService = SpeechService();
  // bool _isListening = false;
  // String _spokenText = '';

  // @override
  // void initState() {
  //   super.initState();
  //   _speechService.initSpeech();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              "Assets/Layer9.png",
            ),
          ),
        ],
        leading: Container(),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: MediaQuery.of(context).size.height / 4,
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
                          padding: EdgeInsets.only(
                              top: 0,
                              right: MediaQuery.of(context).size.width / 19),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: SingleChildScrollView(
                            child: Consumer<SpeechProvider>(
                              builder: (BuildContext context, speechprovider,
                                  Widget? child) {
                                return Text(
                                  speechprovider.spokenText,
                                  style: TextStyle(fontSize: 25),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "Assets/Search.png",
                        width: MediaQuery.of(context).size.width / 15,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                Transform.translate(
                  offset: Offset(-MediaQuery.of(context).size.width / 20, 0),
                  child: Consumer<SpeechProvider>(
                    builder:
                        (BuildContext context, speechprovider, Widget? child) {
                      return InkWell(
                        onTap: () async {
                          await speechprovider.toggleListening();
                        },
                        child: Image.asset(
                          "Assets/Mic.png",
                          width: MediaQuery.of(context).size.width / 8,
                          height: MediaQuery.of(context).size.height / 4,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Imagescreen1();
                    }));
                  },
                  child: Iconwidget(
                    image: 'Assets/image.png',
                    name: 'صورة',
                    fontsize: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Storyscreen();
                    }));
                  },
                  child: Iconwidget(
                    image: 'Assets/story.png',
                    name: 'قصة',
                    fontsize: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Advanturescreen();
                    }));
                  },
                  child: Iconwidget(
                    image: 'Assets/Advantare.png',
                    name: 'مغامرة',
                    fontsize: 30,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Paintscreen();
                    }));
                  },
                  child: Iconwidget(
                    image: 'Assets/colorbook.png',
                    name: 'صورة للتلوين',
                    fontsize: 20,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (BuildContext context) {
                      return Activityscreen();
                    }));
                  },
                  child: Iconwidget(
                    image: 'Assets/activity.png',
                    name: 'اختبار',
                    fontsize: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
