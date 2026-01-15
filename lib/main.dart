import 'package:flutter/material.dart';
import 'package:restaurant_app/pages/food_detail_page.dart';
import 'package:restaurant_app/pages/intro_page.dart';
import 'package:restaurant_app/pages/menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home: IntroPage(),
     routes: {
       '/introPage' : (context) => const IntroPage(),
       '/menuPage' : (context) => const MenuPage(),
       '/foodDetailPage' : (context) => const FoodDetailPage(),
     },
   );
  }
}
