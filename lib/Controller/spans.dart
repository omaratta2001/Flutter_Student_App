import 'package:flutter/material.dart';

RichText buildStyledText(String input, double font) {
  final regex = RegExp(r'\*\*(.*?)\*\*');
  final spans = <TextSpan>[];
  int currentIndex = 0;

  for (final match in regex.allMatches(input)) {
    if (match.start > currentIndex) {
      spans.add(TextSpan(text: input.substring(currentIndex, match.start)));
    }
    spans.add(
      TextSpan(
        text: match.group(1),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
    currentIndex = match.end;
  }

  if (currentIndex < input.length) {
    spans.add(TextSpan(text: input.substring(currentIndex)));
  }

  return RichText(
    text: TextSpan(
      style: TextStyle(color: Colors.black, fontSize: font), // general style
      children: spans,
    ),
  );
}
