import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import 'package:flutter/services.dart';
import '../../roots/routes.dart';
import '../../viewmodels/cart_controller.dart';
import '../cart/widgets/floating_cart_bar.dart';

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

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  final CartController cartController = Get.find<CartController>();
  int quantity = 1;
  bool isFavorite = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> cuts = [
    {
      "name": "Curry Cut",
      "price": 450,
      "image": "assets/images/banner2.jpg",
      "description": "Freshly cut curry fish, ideal for home cooking.",
      "netWeight": "450g • 3-5 pcs",
      "mrp": 500,
      "discount": "10%",
    },
    {
      "name": "Fillet",
      "price": 600,
      "image": "assets/images/banner2.jpg",
      "description": "Premium fillet cut, ready to cook.",
      "netWeight": "500g • 2-3 pcs",
      "mrp": 750,
      "discount": "20%",
    },
    {
      "name": "Whole",
      "price": 350,
      "image": "assets/images/banner2.jpg",
      "description": "Whole fish, fresh and cleaned.",
      "netWeight": "1kg • 1 pc",
      "mrp": 400,
      "discount": "15%",
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        children:[
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.axis == Axis.vertical) {
                final isCollapsedNow =
                    scrollNotification.metrics.pixels >
                        (screenHeight * 0.28 - kToolbarHeight);
                if (_isCollapsed != isCollapsedNow) {
                  setState(() => _isCollapsed = isCollapsedNow);
                }
              }
              return false;
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  expandedHeight: screenHeight * 0.28,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: _isCollapsed
                      ? AppColors.extraLightestPrimary
                      : Colors.transparent,
                  centerTitle: true,
                  title: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0, 0.5),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: _isCollapsed
                        ? Text(
                      widget.productName,
                      key: const ValueKey("title"),
                      style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )
                        : const SizedBox.shrink(
                      key: ValueKey("empty"),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(
                          tag: widget.imageUrl,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                            child: Image.asset(widget.imageUrl, fit: BoxFit.cover),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: _isCollapsed ? AppColors.black : AppColors.white,
                        size: 24,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  actions: _isCollapsed
                      ? []
                      : [
                    Padding(
                      padding: EdgeInsets.only(right: 4.w),
                      child: _buildModernIconButton(
                        icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.grey[700]!,
                        onTap: () {
                          setState(() => isFavorite = !isFavorite);
                        },
                      ),
                    ),
                  ],
                ),
                /// Product Info Section
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 7.w),

                          /// Product Title & Subtitle
                          _buildProductHeader(),
                          SizedBox(height: 6.w),

                          /// Modern Cut Selection
                          _buildCutSelection(screenHeight, screenWidth),
                          const SizedBox(height: 32),

                          /// Enhanced Description
                          _buildDescriptionSection(),
                          const SizedBox(height: 24),

                          /// Modern Info Cards
                          _buildInfoCards(screenWidth),
                          SizedBox(height: screenHeight * 0.12),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // FloatingCartBar(),
          FloatingCartBarWidget(
            totalItems: cartController.totalItems,
            totalPrice: cartController.totalPrice,
            buttonText: "View cart",
            onTap: () {
              Get.toNamed(AppRoutes.cart);
            },
          ),

        ]
      ),
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.productName,
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            height: 1.2,
          ),
        ),
        Text(
          "(Pungus/Keluthi Meen/Assam Vala/Banka  Jella/Sheelan)",
          style: TextStyle(
            color: AppColors.textGrey,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCutSelection(double screenHeight, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Choose Your Cut",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Select the perfect cut for your cooking needs",
          style: TextStyle(fontSize: 15.sp, color: AppColors.textGrey),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 27.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: cuts.length,
            itemBuilder: (context, index) {
              final cut = cuts[index];
              int cutQty = cut["qty"] ?? 0;

              return StatefulBuilder(
                builder: (context, setStateCard) {
                  return Container(
                    width: 35.w,
                    margin: EdgeInsets.only(right: 4.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Image with overlay
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(18),
                                // bottom: Radius.circular(18),
                              ),
                              child: Image.asset(
                                cut["image"],
                                height: screenHeight * 0.12,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            if (cut["discount"] != null)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.accentGreen.withOpacity(
                                      0.6,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    cut["discount"],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        /// Content
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(2.5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cut["name"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  cut["netWeight"],
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 1.h),

                                /// Price Row
                                Row(
                                  children: [
                                    Text(
                                      "₹${cut["price"]}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        color: AppColors.black,
                                      ),
                                    ),
                                    SizedBox(width: 1.5.w),
                                    if (cut["mrp"] != null)
                                      Text(
                                        "₹${cut["mrp"]}",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey[500],
                                          decoration:
                                              TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),

                                const Spacer(),

                                /// Modern Add Button
                                _buildModernAddButton(cut, setStateCard),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModernAddButton(
    Map<String, dynamic> cut,
    StateSetter setStateCard,
  ) {
    int cutQty = cut["qty"] ?? 0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 4.h,
      child: cutQty == 0
          ? ElevatedButton(
              onPressed: () {
                setStateCard(() => cut["qty"] = 1);
                Get.find<CartController>().addItem(1, cut["price"].toDouble());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 18),
                  SizedBox(width: 4),
                  Text("Add", style: TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: AppColors.black),
                    onPressed: () {
                      setStateCard(() {
                        if (cut["qty"] > 1) {
                          cut["qty"]--;
                          Get.find<CartController>().removeItem(1, cut["price"].toDouble());
                        } else {
                          cut["qty"] = 0;
                          Get.find<CartController>().clearCart();
                        }
                      });
                    },
                  ),
                  Text(
                    cut["qty"].toString(),
                    style: TextStyle(
                      fontSize: 4.w,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: AppColors.black),
                    onPressed: () {
                      setStateCard(() => cut["qty"]++);
                      Get.find<CartController>()
                          .addItem(1, cut["price"].toDouble());
                    },
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDescriptionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About This Fish",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
              color: AppColors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Our fish are freshly caught and carefully processed to retain quality and taste. Each piece is hand-selected and cleaned with the utmost care, ensuring you get the finest quality seafood for your table.",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.darkGrey,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildFeatureChip("Fresh Catch", Icons.waves),
              const SizedBox(width: 8),
              _buildFeatureChip("Quality Assured", Icons.verified),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lighterGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.darkGrey),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.darkGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCards(double screenWidth) {
    return Column(
      children: [
        /// FSSAI Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                "assets/images/fassilogo.png",
                height: 32,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "FSSAI Certified",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "Lic. No: 12345678901234",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.verified, color: AppColors.confirmGreen, size: 20),
            ],
          ),
        ),

        const SizedBox(height: 12),

        /// Address Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.extraLightestPrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "123 Marine Street, Coastal City, India",
                  style: TextStyle(fontSize: 14, color: Color(0xFF475569)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernIconButton({
    required IconData icon,
    Color color = Colors.black,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}
