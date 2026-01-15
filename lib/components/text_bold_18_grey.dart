import 'package:flutter/material.dart';

class TextBold18Grey extends StatelessWidget {
  final String text;

  const TextBold18Grey({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.grey[800],
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
