import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../Constants/app_colors.dart';
import '../../constants/api_constants.dart';
import '../../roots/routes.dart';
import '../products/controller/cart_controller.dart';
import '../../viewmodels/category_controller.dart';
import '../../viewmodels/products_controller.dart';
import '../cart/widgets/floating_cart_bar.dart';
import '../products/product_detail_screen.dart';
import '../products/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CartController cartController = Get.find<CartController>();
  final CategoryController categoryController = Get.put(CategoryController());
  final ProductsController productsController = Get.put(ProductsController());

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
  final List<String> carouselItems = [
    "assets/images/banner2.jpg",
    "assets/images/banner2.jpg",
    "assets/images/banner2.jpg",
  ];
  final RxInt carouselIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    productsController.getProducts();
    categoryController.getCategory();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.01),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: buildCarouselSlider(),
                ),
                SizedBox(height: screenHeight * 0.02),

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
                // Bestsellers Section
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.03),
                  child: Obx(() {
                    if (productsController.isLoading.value) {
                      // shimmer-like placeholders while loading
                      return SizedBox(
                        height: screenHeight * 0.30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, __) => Container(
                            width: screenWidth * 0.58,
                            margin: EdgeInsets.only(right: screenWidth * 0.04),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      );
                    }

                    if (productsController.productList.isEmpty) {
                      return SizedBox(
                        height: screenHeight * 0.1,
                        child: Center(
                          child: Text(
                            "No bestsellers found",
                            style: GoogleFonts.nunito(
                              color: AppColors.darkGrey,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                      );
                    }

                    final products = productsController.productList;

                    return SizedBox(
                      height: screenHeight * 0.30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          final imageUrl = product.image != null
                              ? "${ApiConstants.imageBaseUrl}${product.image}"
                              : "assets/images/banner2.jpg";
                          print("image :: $imageUrl");
                          final price = "₹${product.price ?? '0'}";
                          final title = product.name ?? "";
                          final description = product.description ?? "";

                          return _buildProductCard(
                            context,
                            imageUrl,
                            title,
                            description,
                            price,
                            "", // optional old price placeholder
                            "", // optional discount placeholder
                          );
                        },
                      ),
                    );
                  }),
                ),
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
          // FloatingCartBar()
          FloatingCartBarWidget(
            totalItems: cartController.totalItems,
            totalPrice: cartController.totalPrice,
            buttonText: "View cart",
            onTap: () {
              Get.toNamed(AppRoutes.cart);
            },
          ),

        ],
      ),
    );
  }
  Widget buildCarouselSlider() {
    return Column(
      children: [
        CarouselSlider(
          items: carouselItems.map((item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                item,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 10 / 9,
            viewportFraction: 0.95,
            onPageChanged: (index, reason) {
              carouselIndex.value = index;
            },
          ),
        ),

        /// Modern Indicator
        SizedBox(height: 8),
        Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            carouselItems.length,
                (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: carouselIndex.value == index ? 20 : 8,
              decoration: BoxDecoration(
                color: carouselIndex.value == index
                    ? AppColors.primary
                    : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ))

      ],
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

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Get.to(ProductDetailScreen(
          productName: title,
          imageUrl: imageUrl,
        ));
      },
      child: Container(
        width: screenWidth * 0.58,
        margin: EdgeInsets.only(right: screenWidth * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
      
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                height: screenHeight * 0.16,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/banner2.jpg",
                    height: screenHeight * 0.16,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
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
      ),
    );
  }

  // ---------------- Category Grid ----------------
  Widget _buildCategoryGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Obx(() {
      if (categoryController.isLoading.value) {
        // Shimmer effect
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 8, // number of shimmer items
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: screenWidth * 0.02,
            mainAxisSpacing: screenHeight * 0.015,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: screenWidth * 0.18,
                    width: screenWidth * 0.18,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Container(
                    height: screenHeight * 0.02,
                    width: screenWidth * 0.18,
                    color: Colors.white,
                  ),
                ],
              ),
            );
          },
        );
      } else if (categoryController.categoryList.isEmpty) {
        return Center(
          child: Text(
            "No categories found",
            style: TextStyle(fontSize: screenWidth * 0.035),
          ),
        );
      } else {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: categoryController.categoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: screenWidth * 0.02,
            mainAxisSpacing: screenHeight * 0.015,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final category = categoryController.categoryList[index];
            String imageUrl = category.image != null
                ? "${ApiConstants.imageBaseUrl}/${category.image}"
                : "assets/images/p2.png";

            return InkWell(
              onTap: () {
                if (category.id != null) {
                  Get.toNamed(AppRoutes.productScreen,arguments: {'categoryId': category.id});
                } else {
                  Get.snackbar("Error", "Invalid category ID");
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: Image.network(
                      imageUrl,
                      height: screenWidth * 0.18,
                      width: screenWidth * 0.18,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset("assets/images/p2.png",
                              height: screenWidth * 0.18,
                              width: screenWidth * 0.18,
                              fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),
                  Text(
                    category.name ?? "",
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
    });
  }
}
