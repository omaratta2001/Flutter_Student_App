import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/Controller/Providers/HomeScreen_provider.dart';
import 'package:student_app/View/HomeScreen/SelectCategory.dart';
import 'package:student_app/Widget/boxwithnumber.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool? isBoySelected; // Initially, boy is selected
  // List<bool> numberBoxSelections = List.generate(6, (index) => false);
  Uint8List? backgroundImageBytes; // Store the image data

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final homeprovider = Provider.of<HomescreenProvider>(context);

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
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "Assets/icon.png",
                          ),
                          fit: BoxFit.fill)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "النوع",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  )),
                ),
                Expanded(
                  child: Transform.translate(
                    offset: Offset(30, 0),
                    child: Consumer<HomescreenProvider>(
                      builder:
                          (BuildContext context, homeprovider, Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                homeprovider.selectgender(true);
                              },
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "Assets/boy.png",
                                    fit: BoxFit.fill,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                  ),
                                  if (homeprovider.isBoySelected == true)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 4,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            InkWell(
                              onTap: () {
                                homeprovider.selectgender(false);
                              },
                              child: Stack(
                                children: [
                                  Image.asset(
                                    "Assets/Girl.png",
                                    fit: BoxFit.fill,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                  ),
                                  if (homeprovider.isBoySelected == false)
                                    Positioned.fill(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.green,
                                            width: 4,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 6.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "Assets/icon.png",
                          ),
                          fit: BoxFit.fill)),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "السن",
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  )),
                ),
                // SizedBox(
                //   width: 30,
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Consumer<HomescreenProvider>(
                      builder:
                          (BuildContext context, homeprovider, Widget? child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                homeprovider.selectage(0);

                                // setState(() {
                                //   numberBoxSelections =
                                //       List.generate(6, (index) => false);
                                //   numberBoxSelections[0] = true;
                                // });
                              },
                              child: Boxwithnumber(
                                image: "Assets/4.png",
                                isSelected: homeprovider.numberBoxSelections[0],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                homeprovider.selectage(1);

                                // setState(() {
                                //   numberBoxSelections =
                                //       List.generate(6, (index) => false);
                                //   numberBoxSelections[1] = true;
                                // });
                              },
                              child: Boxwithnumber(
                                image: "Assets/5.png",
                                isSelected: homeprovider.numberBoxSelections[1],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                homeprovider.selectage(2);

                                // setState(() {
                                //   numberBoxSelections =
                                //       List.generate(6, (index) => false);
                                //   numberBoxSelections[2] = true;
                                // });
                              },
                              child: Boxwithnumber(
                                image: "Assets/6.png",
                                isSelected: homeprovider.numberBoxSelections[2],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                homeprovider.selectage(3);

                                // setState(() {
                                //   numberBoxSelections =
                                //       List.generate(6, (index) => false);
                                //   numberBoxSelections[3] = true;
                                // });
                              },
                              child: Boxwithnumber(
                                image: "Assets/7.png",
                                isSelected: homeprovider.numberBoxSelections[3],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                homeprovider.selectage(4);

                                // setState(() {
                                //   numberBoxSelections =
                                //       List.generate(6, (index) => false);
                                //   numberBoxSelections[4] = true;
                                // });
                              },
                              child: Boxwithnumber(
                                image: "Assets/8.png",
                                isSelected: homeprovider.numberBoxSelections[4],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                homeprovider.selectage(5);

                                // setState(() {
                                //   numberBoxSelections =
                                //       List.generate(6, (index) => false);
                                //   numberBoxSelections[5] = true;
                                // });
                              },
                              child: Boxwithnumber(
                                image: "Assets/9.png",
                                isSelected: homeprovider.numberBoxSelections[5],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Consumer<HomescreenProvider>(
                    builder:
                        (BuildContext context, homeprovider, Widget? child) {
                      return InkWell(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          if (homeprovider.isBoySelected == true) {
                            prefs.setString('Isboy', 'ولد');
                            print("you are boy ");
                          } else {
                            prefs.setString('Isboy', 'بنت');
                          }

                          // for (int i = 0; i < numberBoxSelections.length; i++) {
                          //   if (numberBoxSelections[i]) {
                          //     prefs.setString("age", '${i + 4}');
                          //     print("the age is ${i + 4}");
                          //   }
                          // }

                          prefs.setString(
                              'age', '${homeprovider.getselectedage()}');
                          for (int i = 0;
                              i < homeprovider.numberBoxSelections.length;
                              i++) {
                            if (homeprovider.isBoySelected != null &&
                                homeprovider.numberBoxSelections[i] == true) {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return SelectionCategory();
                              }));
                            }
                          }
                        },
                        child: Image.asset(
                          "Assets/Next.png",
                          width: 80,
                          height: 80,
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
