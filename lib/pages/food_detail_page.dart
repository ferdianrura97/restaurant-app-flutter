import 'package:flutter/material.dart';
import 'package:restaurant_app/components/alert.dart';
import 'package:restaurant_app/components/button.dart';
import 'package:restaurant_app/components/rating_star.dart';
import 'package:restaurant_app/components/text_bold_18_grey.dart';
import 'package:restaurant_app/models/food.dart';
import 'package:restaurant_app/theme/colors.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  Food get food => ModalRoute.of(context)!.settings.arguments as Food;
  int quantityCount = 0;

  void incrementQuantity() {
    setState(() {
      quantityCount++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantityCount > 0) {
        quantityCount--;
      }
    });
  }

  void addToCart() {
    showDialog(
      context: context,
      builder: (context) => AppAlert(
        title: "Sorry",
        description: "Haven't Studied State Yet\nBtw, your input is $quantityCount item",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ListView(
                children: [
                  Image.asset(food.imagePath, height: 200),
                  RatingStar(text: food.rating),
                  SizedBox(height: 10),
                  Text(
                    food.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.grey[900],
                    ),
                  ),
                  SizedBox(height: 20),
                  TextBold18Grey(text: "Description"),
                  SizedBox(height: 10),
                  Text(
                    food.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: primaryColor,
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      food.price,
                      style: TextStyle(
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.remove, color: Colors.white),
                            onPressed: decrementQuantity,
                          ),
                        ),

                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              quantityCount.toString(),
                              style: TextStyle(
                                color: Colors.grey[200],
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            color: secondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: incrementQuantity,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Button(
                  text: "Add To Cart",
                  onPressed: addToCart,
                  iconData: Icons.shopping_basket_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
