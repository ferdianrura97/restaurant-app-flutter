import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/colors.dart';

class AppAlert extends StatelessWidget {
  final String title;
  final String description;

  const AppAlert({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 22),
      ),
      content: Text(
        description,
        style: TextStyle(color: Colors.grey[300], fontSize: 16),
      ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.done, color: Colors.white),
        ),
      ],
    );
  }
}
