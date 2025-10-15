import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import 'package:flutter/services.dart';
import '../../roots/routes.dart';
import 'controller/cart_controller.dart';
import '../cart/widgets/floating_cart_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

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

  final RxInt selectedCutIndex = (-1).obs;
  final RxInt selectedWeightIndex = (-1).obs;
  final RxDouble selectedPrice = 0.0.obs;

  final List<Map<String, dynamic>> cuts = [
    {"name": "Fry Cut", "price": 450, "image": "assets/images/banner2.jpg", "mrp": 500},
    {"name": "Curry Cut", "price": 600, "image": "assets/images/banner2.jpg", "mrp": 750},
  ];
  final List<String> weights = [
    "0.25 kg", "0.5 kg", "1 kg", "1.5 kg", "2 kg", "2.5 kg",
  ];
  bool _isCollapsed = false;
  late String productName;
  late String imageUrl;


  @override
  void initState() {
    super.initState();
    /// 🔹 Receive arguments from Get.toNamed()
    final args = Get.arguments ?? {};
    productName = args['productName'] ?? 'Unknown Product';
    imageUrl = args['imageUrl'] ?? '';

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
  void _updateCartTotal() {
    if (selectedCutIndex.value != -1 && selectedWeightIndex.value != -1) {
      final cut = cuts[selectedCutIndex.value];
      final basePrice = cut["price"].toDouble();

      // Extract weight value (e.g. "1 kg" → 1.0)
      final selectedWeightText = weights[selectedWeightIndex.value];
      final double weight = double.parse(selectedWeightText.split(" ")[0]);

      final double total = basePrice * weight;

      cartController.totalItems.value = 1;
      cartController.totalPrice.value = total;
    } else {
      cartController.totalItems.value = 0;
      cartController.totalPrice.value = 0.0;
    }
  }

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
                      productName,
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
                          tag: imageUrl,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/banner2.jpg",
                                fit: BoxFit.cover,
                              ),
                            ),
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
                  // actions: _isCollapsed
                  //     ? []
                  //     : [
                  //   Padding(
                  //     padding: EdgeInsets.only(right: 4.w),
                  //     child: _buildModernIconButton(
                  //       icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                  //       color: isFavorite ? Colors.red : Colors.grey[700]!,
                  //       onTap: () {
                  //         setState(() => isFavorite = !isFavorite);
                  //       },
                  //     ),
                  //   ),
                  // ],
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
                          SizedBox(height: 6.w),

                          _buildWeightSelection(),
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
          Obx(() {
            if (selectedCutIndex.value != -1 && selectedWeightIndex.value != -1) {
              return FloatingCartBarWidget(
                totalItems: cartController.totalItems,
                totalPrice: cartController.totalPrice,
                buttonText: "View cart",
                onTap: () => Get.toNamed(AppRoutes.cart),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
        ]
      ),
    );
  }

  Widget _buildProductHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: TextStyle(
            fontSize: 21.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            height: 1.2,
          ),
        ),
        SizedBox(height: 1.w),
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
          height: 22.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: cuts.length,
            itemBuilder: (context, index) {
              final cut = cuts[index];

              return Obx(() {
                bool isSelected = selectedCutIndex.value == index;

                return GestureDetector(
                  onTap: () {
                    if (selectedCutIndex.value == index) {
                      selectedCutIndex.value = -1;
                      selectedPrice.value = 0.0;
                    } else {
                      selectedCutIndex.value = index;
                      selectedPrice.value = cut["price"].toDouble();
                    }
                    _updateCartTotal();
                  },
                  child: Container(
                    width: 35.w,
                    margin: EdgeInsets.only(right: 4.w),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.white
                          : AppColors.lightGrey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Image with overlay
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(18),
                          ),
                          child: Image.asset(
                            cut["image"],
                            height: screenHeight * 0.12,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
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
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeightSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Weight",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Select your preferred weight",
          style: TextStyle(fontSize: 15.sp, color: AppColors.textGrey),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(weights.length, (index) {
            return Obx(() {  // <-- Obx per item
              bool isSelected = selectedWeightIndex.value == index;
              return GestureDetector(
                onTap: () {
                  if (selectedWeightIndex.value == index) {
                    selectedWeightIndex.value = -1;
                  } else {
                    selectedWeightIndex.value = index;
                  }
                  _updateCartTotal();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.lightGrey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.lighterPrimary,
                      width: isSelected ? 1.5 : 0.5,
                    ),
                  ),
                  child: Text(
                    weights[index],
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: isSelected ? AppColors.primary : AppColors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            });
          }),
        ),

      ],
    );
  }
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

