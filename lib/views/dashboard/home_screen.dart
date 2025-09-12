import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            // Banner (Smooth Carousel)
            SizedBox(
              height: screenHeight * 0.20,
              width: double.infinity,
              child: _buildBanner(context, "assets/images/banner2.jpg"),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Bestsellers title
            Text(
              "Bestsellers",
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.050,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Text(
              "Most popular products near you!",
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.035,
                color: AppColors.darkGrey,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Horizontal Scroll - Products
            SizedBox(
              height: screenHeight * 0.30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildProductCard(
                    context,
                    "assets/images/banner2.jpg",
                    "Chicken Curry Cut - Small Pieces",
                    "500 g | 12-18 Pieces | Serves 4",
                    "₹171",
                    "₹209",
                    "18% off",
                  ),
                  _buildProductCard(
                    context,
                    "assets/images/banner2.jpg",
                    "Chicken Curry Cut - Big Pieces",
                    "500 g | 7-11 Pieces | Serves 3",
                    "₹171",
                    "₹209",
                    "18% off",
                  ),
                  _buildProductCard(
                    context,
                    "assets/images/banner2.jpg",
                    "Chicken Curry Cut - Small Pieces",
                    "500 g | 12-18 Pieces | Serves 4",
                    "₹171",
                    "₹209",
                    "18% off",
                  ),
                  _buildProductCard(
                    context,
                    "assets/images/banner2.jpg",
                    "Chicken Curry Cut - Big Pieces",
                    "500 g | 7-11 Pieces | Serves 3",
                    "₹171",
                    "₹209",
                    "18% off",
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            // Shop by Category Section
            Text(
              "Shop by category",
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.050,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            Text(
              "Freshest meats and much more!",
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.035,
                color: AppColors.darkGrey,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // category grid
            _buildCategoryGrid(context),


          ],
        ),
      ),
    );
  }

  // ---------------- Banner widget ----------------
  Widget _buildBanner(BuildContext context, String assetPath) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        width: screenWidth,
      ),
    );
  }

  // ---------------- Product Card widget ----------------
  Widget _buildProductCard(
      BuildContext context,
      String imageUrl,
      String title,
      String subtitle,
      String price,
      String oldPrice,
      String discount,
      ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.56,
      margin: EdgeInsets.only(right: screenWidth * 0.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)
            ),
            child: Image.asset(
              imageUrl, // pass the asset path here
              height: screenHeight * 0.16,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),


          Padding(
            padding: EdgeInsets.all(screenWidth * 0.025),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.nunito(
                    fontSize: screenWidth * 0.039,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  subtitle,
                  style: GoogleFonts.nunito(
                    fontSize: screenWidth * 0.028,
                    color: AppColors.darkGrey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.008),
                Row(
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      oldPrice,
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.030,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      discount,
                      style: GoogleFonts.nunito(
                        fontSize: screenWidth * 0.030,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Category Grid ----------------
  Widget _buildCategoryGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<Map<String, String>> categories = [
      // Fresh Fish
      {"title": "Pomfret"},
      {"title": "Bombil"},
      {"title": "Mackerel"},
      {"title": "Prawns & Crabs"},
      {"title": "Seawater Fish"},
      {"title": "Freshwater Fish"},
      {"title": "Combos"},

      // Dry Fish
      {"title": "Sukat"},
      {"title": "Bombil"},
      {"title": "Tisrya"},
      {"title": "Mandeli"},
      {"title": "Tingli"},
      {"title": "Ribbon"},
      {"title": "Dandi"},
      {"title": "Crabs"},
      {"title": "Pickles"},
    ];


    final Random random = Random(); // for random selection

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: screenWidth * 0.02,
        mainAxisSpacing: screenHeight * 0.015,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        // Randomly pick p2.png or p3.png for each item
        String randomImage = random.nextBool()
            ? "assets/images/p2.png"
            : "assets/images/p2.png";

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: Image.asset(
                randomImage,
                height: screenWidth * 0.18,
                width: screenWidth * 0.18,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: screenHeight * 0.008),
            Text(
              categories[index]["title"]!,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: screenWidth * 0.030,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
