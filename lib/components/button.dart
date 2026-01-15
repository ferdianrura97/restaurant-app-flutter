import 'package:flutter/material.dart';
import 'package:restaurant_app/theme/colors.dart';

class Button extends StatelessWidget {
  final String text;
  final String? route;
  final VoidCallback? onPressed;
  final IconData? iconData;

  const Button({
    super.key,
    required this.text,
    this.route,
    this.onPressed,
    this.iconData = Icons.arrow_forward_sharp
  });


  void _handlePressed(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
      return;
    }
    if (route != null && route!.isNotEmpty) {
      Navigator.pushNamed(context, route!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (onPressed == null && (route == null || route!.isEmpty))
          ? null
          : () => _handlePressed(context),
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.all(20)),
        backgroundColor: WidgetStatePropertyAll(
          secondaryColor,
        ),
        alignment: AlignmentGeometry.center,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(color: Colors.grey[300], fontSize: 18)),

          SizedBox(width: 10),

          Icon(iconData, color: Colors.white, size: 22),
        ],
      ),
    );
  }
}
