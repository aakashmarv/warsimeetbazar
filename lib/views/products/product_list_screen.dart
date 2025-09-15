import 'package:dry_fish/views/products/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/app_colors.dart';

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

    final selectedCategory = categories[selectedIndex];
    final categoryProducts = products[selectedCategory] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategory),
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
            child: GridView.builder(
              padding: EdgeInsets.all(screenWidth * 0.02),
              itemCount: categoryProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: screenWidth * 0.03,
                mainAxisSpacing: screenHeight * 0.01,
                childAspectRatio: 0.60,
              ),
              itemBuilder: (context, index) {
                final product = categoryProducts[index];
                return InkWell(
                  onTap: (){
                    Get.to( ProductDetailScreen(
                      productName: product["title"]!,
                      imageUrl: product["image"]!,
                    ),);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image section
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.asset(
                            product["image"]!,
                            height: screenHeight * 0.15,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Text section take remaining space
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product["title"]!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.035,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  product["price"]!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.035,
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
        ],
      ),
    );
  }
}
