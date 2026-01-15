import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/components/alert.dart';
import 'package:restaurant_app/components/button.dart';
import 'package:restaurant_app/components/food_tile.dart';
import 'package:restaurant_app/components/text_bold_18.dart';
import 'package:restaurant_app/components/text_bold_18_grey.dart';
import 'package:restaurant_app/data/food_data.dart';
import 'package:restaurant_app/theme/colors.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AppAlert(
                title: "Sorry",
                description: "Under Development, Coming Soon",
              ),
            );
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          "Restaurant App",
          style: TextStyle(color: Colors.grey[900]),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AppAlert(
                    title: "Sorry",
                    description: "Under Development, Coming Soon",
                  ),
                );
              },
              icon: Icon(Icons.shopping_basket),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: EdgeInsetsGeometry.only(bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // PROMO
              Card(
                color: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Get 32% Promo",
                                style: GoogleFonts.dmSerifDisplay(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 20),
                              Button(
                                text: "Redeem",
                                iconData: Icons.discount_rounded,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AppAlert(
                                      title: "Sorry",
                                      description:
                                          "Under Development, Coming Soon",
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),

                          Flexible(
                            child: Image.asset(
                              "lib/images/salmon-eggs.png",
                              height: 100,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 25),

              TextField(
                onSubmitted: (value) {
                  showDialog(
                    context: context,
                    builder: (context) => AppAlert(
                      title: "Sorry",
                      description: "Under Development, Coming Soon",
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Search Here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),

              SizedBox(height: 20),

              TextBold18Grey(text: "Food Menu"),

              SizedBox(height: 20),

              SizedBox(
                height: 270,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 200,
                        child: FoodTile(food: foodMenuData[index]),
                      ),
                    );
                  },
                  itemCount: foodMenuData.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),

              SizedBox(height: 20),

              TextBold18Grey(text: "Favorite Menu"),

              Column(
                children: favoriteFood.map((item) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/foodDetailPage",
                        arguments: item,
                      );
                    },
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(item.imagePath, height: 80),

                                SizedBox(width: 20),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold18(text: item.name),
                                    Text(
                                      item.price,
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Icon(Icons.favorite, color: Colors.red[800]),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
