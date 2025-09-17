import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/app_colors.dart';
import '../products/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "Amit Sharma",
      "rating": 5,
      "comment": "Excellent quality and super fresh! Delivery was quick too."
    },
    {
      "name": "Priya Verma",
      "rating": 4,
      "comment": "Good taste and hygiene. Packaging could be better."
    },
    {
      "name": "Rahul Singh",
      "rating": 5,
      "comment": "Loved it! The fish was fresh and portion size perfect."
    },
    {
      "name": "Sneha Iyer",
      "rating": 4,
      "comment": "Great variety, definitely ordering again!"
    },
  ];


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            // Banner (Smooth Carousel)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: SizedBox(
                height: screenHeight * 0.20,
                width: double.infinity,
                child: _buildBanner(context, "assets/images/banner2.jpg"),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Bestsellers title

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Text(
                "Bestsellers",
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.050,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Text(
                "Most popular products near you!",
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // Horizontal Scroll - Products
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.03),
              child: SizedBox(
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
            ),
            SizedBox(height: screenHeight * 0.01),
            // Shop by Category Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Text(
                "Shop by category",
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.050,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Text(
                "Freshest meats and much more!",
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            // category grid
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: _buildCategoryGrid(context),
            ),
            // Customer Reviews Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Text(
                "Customer Reviews",
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.050,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Text(
                "What our customers say about us",
                style: GoogleFonts.nunito(
                  fontSize: screenWidth * 0.035,
                  color: AppColors.darkGrey,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            SizedBox(
              height: screenHeight * 0.22,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return Container(
                    width: screenWidth * 0.7,
                    margin: EdgeInsets.only(right: screenWidth * 0.04),
                    child: Stack(
                      children: [
                        // Watermark background
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              "assets/images/bgImages/reviewWhatermark.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // Review content
                        Container(
                          padding: EdgeInsets.all(screenWidth * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Customer name + rating
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    review["name"],
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      5,
                                          (star) => Icon(
                                        Icons.star,
                                        size: screenWidth * 0.045,
                                        color: star < review["rating"]
                                            ? Colors.amber
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.01),

                              // Comment
                              Expanded(
                                child: Text(
                                  review["comment"],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
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

        return InkWell(
          onTap: () {
            Get.to(() => ProductListScreen(
              category: categories[index]["title"]!,
            ));
          },
          child: Column(
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
          ),
        );
      },
    );
  }
}
