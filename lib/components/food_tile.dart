import 'package:flutter/material.dart';
import 'package:restaurant_app/components/rating_star.dart';
import 'package:restaurant_app/components/text_bold_18.dart';
import 'package:restaurant_app/models/food.dart';

class FoodTile extends StatelessWidget {
  final Food food;

  const FoodTile({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/foodDetailPage', arguments: food);
      },
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(food.imagePath, height: 150),

              TextBold18(text: food.name),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    food.price,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
      
                  Row(
                    children: [
                      RatingStar(text: food.rating,)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
