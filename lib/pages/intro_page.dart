import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/components/button.dart';
import 'package:restaurant_app/theme/colors.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final isLandscape = width > height;

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: height * 0.04,
              ),
              child: isLandscape
                  ? _buildLandscape(width, height)
                  : _buildPortrait(width, height),
            );
          },
        ),
      ),
    );
  }

  // Portrait (Fix Responsive)
  Widget _buildPortrait(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "RESTAURANT APP",
          style: GoogleFonts.dmSerifDisplay(
            color: Colors.white,
            fontSize: width < 360 ? 22 : 28,
          ),
        ),

        const Spacer(),

        Center(
          child: Image.asset(
            "lib/images/salmon-eggs.png",
            height: height * 0.28,
            fit: BoxFit.contain,
          ),
        ),

        const Spacer(),

        Text(
          "THE TASTE OF JAPANESE FOOD",
          style: GoogleFonts.dmSerifDisplay(
            fontSize: width < 360 ? 30 : 40,
            color: Colors.white,
            height: 1.1,
          ),
        ),

        SizedBox(height: height * 0.015),

        Text(
          "Feel the taste of the most popular Japanese food from anywhere and anytime",
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: width < 360 ? 13 : 15,
            height: 1.5,
          ),
        ),

        SizedBox(height: height * 0.025),

        SizedBox(
          width: double.infinity,
          child: Button(
            text: "Get Started",
            route: '/menuPage',
          ),
        ),
      ],
    );
  }

  // Landscape (Fix Responsive)
  Widget _buildLandscape(double width, double height) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "RESTAURANT APP",
                style: GoogleFonts.dmSerifDisplay(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),

              const Spacer(),

              Text(
                "THE TASTE OF JAPANESE FOOD",
                style: GoogleFonts.dmSerifDisplay(
                  fontSize: 36,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),

              SizedBox(height: height * 0.02),

              Text(
                "Feel the taste of the most popular Japanese food from anywhere and anytime",
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              SizedBox(height: height * 0.03),

              SizedBox(
                width: 200,
                child: Button(
                  text: "Get Started",
                  route: '/menuPage',
                ),
              ),
            ],
          ),
        ),

        Expanded(
          flex: 4,
          child: Center(
            child: Image.asset(
              "lib/images/salmon-eggs.png",
              height: height * 0.6,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
