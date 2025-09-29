import 'package:dry_fish/viewmodels/cart_controller.dart';
import 'package:dry_fish/views/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import 'package:flutter/services.dart';

class ProductListScreen extends StatefulWidget {
  final String category;
  const ProductListScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  int selectedIndex = 0;

  final List<String> categories = [
    "Fresh Water",
    "Sea Fish",
    "Prawns",
    "Pomfret",
    "Bombil",
    "Mackerel",
    "Prawns & Crabs",
    "Combos",
    "Sukat",
    "Tisrya",
    "Mandeli",
    "Tingli",
    "Ribbon",
    "Dandi",
  ];

  final Map<String, List<Map<String, String>>> products = {
    "Fresh Water": [
      {"title": "Aar/Ayr/Singhara", "price": "₹500", "image": "assets/images/banner2.jpg"},
      {"title": "Aar/Singhara Steak", "price": "₹800", "image": "assets/images/banner2.jpg"},
      {"title": "Bangladesh Illish", "price": "₹1700", "image": "assets/images/banner2.jpg"},
      {"title": "Aar/Ayr/Singhara", "price": "₹500", "image": "assets/images/banner2.jpg"},
      {"title": "Aar/Singhara Steak", "price": "₹800", "image": "assets/images/banner2.jpg"},
      {"title": "Bangladesh Illish", "price": "₹1700", "image": "assets/images/banner2.jpg"},
      {"title": "Aar/Ayr/Singhara", "price": "₹500", "image": "assets/images/banner2.jpg"},
      {"title": "Aar/Singhara Steak", "price": "₹800", "image": "assets/images/banner2.jpg"},
      {"title": "Bangladesh Illish", "price": "₹1700", "image": "assets/images/banner2.jpg"},{"title": "Aar/Ayr/Singhara", "price": "₹500", "image": "assets/images/banner2.jpg"},
      {"title": "Aar/Singhara Steak", "price": "₹800", "image": "assets/images/banner2.jpg"},
      {"title": "Bangladesh Illish", "price": "₹1700", "image": "assets/images/banner2.jpg"},
    ],
    "Sea Fish": [
      {"title": "Pomfret", "price": "₹900", "image": "assets/images/banner2.jpg"},
      {"title": "Mackerel", "price": "₹400", "image": "assets/images/banner2.jpg"},
    ],
    "Prawns": [
      {"title": "Tiger Prawns", "price": "₹1200", "image": "assets/images/banner2.jpg"},
    ],
    "Pomfret": [
      {"title": "Black Pomfret", "price": "₹950", "image": "assets/images/banner2.jpg"},
      {"title": "White Pomfret", "price": "₹1100", "image": "assets/images/banner2.jpg"},
    ],
    "Bombil": [
      {"title": "Fresh Bombil", "price": "₹350", "image": "assets/images/banner2.jpg"},
    ],
    "Mackerel": [
      {"title": "Big Mackerel", "price": "₹420", "image": "assets/images/banner2.jpg"},
    ],
    "Prawns & Crabs": [
      {"title": "Sea Crab", "price": "₹600", "image": "assets/images/banner2.jpg"},
    ],
    "Combos": [
      {"title": "Family Combo Pack", "price": "₹1500", "image": "assets/images/banner2.jpg"},
    ],
    "Sukat": [ {"title": "Family Combo Pack", "price": "₹1500", "image": "assets/images/banner2.jpg"},],
    "Tisrya": [ {"title": "Family Combo Pack", "price": "₹1500", "image": "assets/images/banner2.jpg"},],
    "Mandeli": [ {"title": "Family Combo Pack", "price": "₹1500", "image": "assets/images/banner2.jpg"},],
    "Tingli": [ {"title": "Family Combo Pack", "price": "₹1500", "image": "assets/images/banner2.jpg"},],
    "Ribbon": [ {"title": "Family Combo Pack", "price": "₹1500", "image": "assets/images/banner2.jpg"},],
    "Dandi": [ {"title": "Family Combo Pack", "price": "₹1500", "image": "assets/images/banner2.jpg"},],
  };

  @override
  void initState() {
    super.initState();
    final index = categories.indexOf(widget.category);
    if (index != -1) {
      selectedIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final ratio = screenWidth / (screenHeight * 0.78);

    final selectedCategory = categories[selectedIndex];
    final categoryProducts = products[selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(selectedCategory,style: TextStyle(
          fontSize: 19.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Row(
        children: [
          /// Left side category list (scrollable)
          Container(
            width: screenWidth * 0.25,
            color: AppColors.bgColor,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.white : Colors.transparent,
                      border: isSelected
                          ? const Border(left: BorderSide(color: AppColors.primary, width: 3))
                          : null,
                    ),
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            "assets/images/p2.png", // dummy
                            height: screenWidth * 0.12,
                            width: screenWidth * 0.12,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          categories[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: screenWidth * 0.030,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? AppColors.primary : AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          /// Right side product grid (scrollable separately)
          Expanded(
            child: SafeArea(
              child: GridView.builder(
                padding: EdgeInsets.all(screenWidth * 0.02),
                itemCount: categoryProducts.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: screenWidth * 0.03,
                    // mainAxisSpacing: screenHeight * 0.015,
                    childAspectRatio: ratio // card height adjust
                ),
                itemBuilder: (context, index) {
                  final product = categoryProducts[index];
                  return InkWell(
                    onTap: () {
                      Get.to(ProductDetailScreen(
                        productName: product["title"]!,
                        imageUrl: product["image"]!,
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: AppColors.extraLightestPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image section
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              product["image"]!,
                              height: screenHeight * 0.14,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
              
                          // Text section
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(screenWidth * 0.025),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product["title"]!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                  ),
                                  SizedBox(height: screenWidth * 0.002),
                                  Text(
                                    "(sdkhfksjfklssdljk dkshf sdlhfsdkhfisdo sdiohfifj)",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColors.darkGrey,
                                      fontSize: screenWidth * 0.030,
                                    ),
                                  ),
                                   SizedBox(height: screenWidth * 0.013),
                                  Text(
                                    product["price"]!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.036,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )

        ],
      ),
    );
  }
}
