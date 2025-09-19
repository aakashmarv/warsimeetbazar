import 'package:dry_fish/roots/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/app_colors.dart';
import '../../widgets/custom_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final String imageUrl;
  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.imageUrl,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String selectedCut = "Curry Cut";
  String selectedWeight = "500g";
  int quantity = 1;
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              /// Collapsing AppBar with product image
              SliverAppBar(
                expandedHeight: screenHeight * 0.4,
                backgroundColor: Colors.transparent,
                elevation: 0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                    child: Image.asset(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: _buildCircleIcon(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: _buildCircleIcon(
                        icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black,
                        onTap: () {
                          setState(() => isFavorite = !isFavorite);
                        },
                      ),
                    ),
                  ),
                ],

              ),
              /// Product Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Freshly caught from the ocean!",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: screenWidth * 0.038,
                        ),
                      ),

                      const SizedBox(height: 20),
                      Text("Select Cut",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        children: ["Curry Cut", "Fillet", "Whole"].map((cut) {
                          return ChoiceChip(
                            label: Text(cut),
                            selected: selectedCut == cut,
                            selectedColor: AppColors.primary, // solid color
                            labelStyle: TextStyle(
                              color: selectedCut == cut ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            onSelected: (val) {
                              setState(() => selectedCut = cut);
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 20),
                      Text("Weight",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        children: ["500g", "1kg"].map((w) {
                          return ChoiceChip(
                            label: Text(w),
                            selected: selectedWeight == w,
                            selectedColor: AppColors.primary,
                            labelStyle: TextStyle(
                              color: selectedWeight == w ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            onSelected: (val) {
                              setState(() => selectedWeight = w);
                            },
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "₹450",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon:
                                const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                },
                              ),
                              Text(quantity.toString(),
                                  style: const TextStyle(fontSize: 18)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  setState(() => quantity++);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.12), // for spacing

                    ],
                  ),
                ),
              ),
            ],
          ),
          /// Sticky Add to Cart Button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.015,
                ),
                child: CustomButton(
                text: "Add to Cart",
    withShadow: true,
    onTap: () {
    Get.toNamed(
    AppRoutes.cart,
    arguments: {
    "name": widget.productName,
    "image": widget.imageUrl,
    "cut": selectedCut,
    "weight": selectedWeight,
    "qty": quantity,
    "price": 450, // or dynamic price if you have
    },
    );
    },
    ),

    ),
            ),
          ),
        ],
      ),
    );
  }

  /// Reusable rounded icon button
  Widget _buildCircleIcon({
    required IconData icon,
    Color color = Colors.black,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 40,  // fixed size
        width: 40,   // fixed size
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Icon(icon, color: color, size: 22),
      ),
    );
  }

}
