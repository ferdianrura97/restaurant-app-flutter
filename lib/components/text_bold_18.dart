import 'package:flutter/material.dart';

class TextBold18 extends StatelessWidget {
  final String text;
  const TextBold18({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
