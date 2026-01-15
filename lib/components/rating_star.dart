import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final String text;

  const RatingStar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.yellow[800]),
        Text(text, style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
