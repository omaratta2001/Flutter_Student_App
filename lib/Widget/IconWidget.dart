// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Iconwidget extends StatelessWidget {
  final String image;
  final String name;
  final double fontsize;
  const Iconwidget(
      {Key? key,
      required this.image,
      required this.name,
      required this.fontsize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Transform.translate(
          offset: Offset(0, 100),
          child: Stack(
            children: [
              Container(
                height: 50,
                width: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Assets/Layer43.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    name,
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: fontsize,
                    //       fontWeight: FontWeight.bold),
                    style: GoogleFonts.notoSansArabic(
                        textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: fontsize,
                    )),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(5, -105),
                child: Image.asset(
                  width: 120,
                  height: 120,
                  image,
                  fit: BoxFit.cover, // Ensures the entire image is visible
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
