import 'package:flutter/material.dart';

class Boxwithnumber extends StatelessWidget {
  final String image;
  final bool isSelected; // Add isSelected parameter
  const Boxwithnumber({
    Key? key,
    required this.image,
    this.isSelected = false, // Default to false
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: GestureDetector(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                image,
                width: MediaQuery.of(context).size.width / 10,
                height: MediaQuery.of(context).size.height / 4,
                fit: BoxFit.fill,
              ),
              if (isSelected)
                Positioned.fill(
                  left: -1,
                  bottom: 0,
                  child: ClipRRect(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.green,
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
