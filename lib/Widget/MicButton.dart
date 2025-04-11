import 'package:flutter/material.dart';

class Micbutton extends StatelessWidget {
  const Micbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              height: 120,
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
                      borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                "Assets/Search.png",
                width: 70,
                height: 70,
              ),
            )
          ],
        ),
        Positioned(
          right: 50,
          top: 10,
          child: InkWell(
            onTap: () {},
            child: Image.asset(
              "Assets/Mic.png",
              width: 100,
              height: 100,
            ),
          ),
        )
      ],
    );
  }
}
