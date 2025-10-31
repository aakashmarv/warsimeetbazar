import 'package:dry_fish/views/cart/widgets/floating_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../constants/api_constants.dart';
import '../../models/responses/cart_response.dart';
import '../../roots/routes.dart';
import '../../utils/toast_util.dart';
import '../../viewmodels/cart_item_controller.dart';
import '../../viewmodels/increase_quantity_controller.dart';
import '../../viewmodels/reduce_quantity_controller.dart';
import '../../viewmodels/remove_cartitem_controller.dart';
import '../../widgets/custom_text_app_bar.dart';

class CartScreen extends StatefulWidget {
  final bool showAppBar;

  const CartScreen({super.key, this.showAppBar = true});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartItemController cartitemController = Get.find<CartItemController>();
  final RemoveCartItemController removeCartItemController =
  Get.put(RemoveCartItemController());
  final ReduceQuantityController reduceQuantityController =
  Get.put(ReduceQuantityController());
  final IncreaseQuantityController increaseQuantityController =
  Get.put(IncreaseQuantityController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartitemController.fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: widget.showAppBar
          ? AppBar(
        backgroundColor: AppColors.extraLightestPrimary,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      )
          : const CustomTextAppBar(title: "Cart"),
      body: Obx(() {
        if (cartitemController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final cartItems = cartitemController.cartItems;

        if (cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 100,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 16),
                Text(
                  "Your cart is empty",
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Add items to get started",
                  style: GoogleFonts.nunito(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 100.h,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _buildModernCartItem(item);
                    },
                  ),
                ),
              ],
            ),

            /// Checkout Bottom Bar
            FloatingCartBarWidget(
              totalItems: cartitemController.totalItems,
              totalPrice: cartitemController.totalPrice,
              buttonText: "Checkout",
              onTap: () {
                Get.toNamed(AppRoutes.Checkout);
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildModernCartItem(CartItem item) {
    final imageUrl = (item.product?.image?.isNotEmpty ?? false)
        ? "${ApiConstants.imageBaseUrl}${item.product?.image}"
        : "assets/images/banner2.jpg";

    final productName = item.product?.name ?? 'Unknown Product';
    final productWeight = item.weight?.toString() ?? 'N/A';
    final productPrice = item.price ?? 0.0;
    final quantity = item.quantity ?? 0;
    final total = item.total ?? 0.0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        productName,
                        style: GoogleFonts.nunito(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Weight
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 10,
                      //     vertical: 4,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     color: AppColors.primary.withOpacity(0.1),
                      //     borderRadius: BorderRadius.circular(6),
                      //   ),
                      //   child: Text(
                      //     productWeight,
                      //     style: GoogleFonts.nunito(
                      //       fontSize: 12.sp,
                      //       fontWeight: FontWeight.w600,
                      //       color: AppColors.primary,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 8),

                      // Price Calculation Display
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.nunito(
                            fontSize: 13.sp,
                            color: Colors.grey[600],
                          ),
                          children: [
                            TextSpan(
                              text: productWeight,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: " × "),
                            TextSpan(
                              text: "$quantity",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: " × "),
                            TextSpan(
                              text: "₹${productPrice.toStringAsFixed(0)}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Total Price
                      Text(
                        "₹${total.toStringAsFixed(2)}",
                        style: GoogleFonts.nunito(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.grey[300]!,
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Quantity Controls & Remove Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Remove Button
                TextButton.icon(
                  onPressed: () async {
                    final id = item.id.toString();
                    await removeCartItemController.removeCartItem(id);

                    if (removeCartItemController.successMessage.isNotEmpty) {
                      ToastUtil.showSuccess(
                          removeCartItemController.successMessage.value);
                      cartitemController.fetchItems();
                    } else if (removeCartItemController
                        .errorMessage.isNotEmpty) {
                      ToastUtil.showError(
                          removeCartItemController.errorMessage.value);
                    }
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red[400],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 20,
                    color: Colors.red[400],
                  ),
                  label: Text(
                    "Remove",
                    style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // Quantity Selector
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Decrease Button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            final id = item.id.toString();
                            await reduceQuantityController.reduceQuantity(id);

                            if (reduceQuantityController.isSuccess.isTrue) {
                              ToastUtil.showSuccess(
                                  reduceQuantityController.message.value);
                              cartitemController.fetchItems();
                            } else {
                              ToastUtil.showError(
                                  reduceQuantityController.message.value);
                            }
                          },
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.remove,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),

                      // Quantity Display
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "$quantity",
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),

                      // Increase Button
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            final id = item.id.toString();
                            await increaseQuantityController
                                .increaseQuantity(id);

                            if (increaseQuantityController.isSuccess.isTrue) {
                              ToastUtil.showSuccess(
                                  increaseQuantityController.message.value);
                              cartitemController.fetchItems();
                            } else {
                              ToastUtil.showError(
                                  increaseQuantityController.message.value);
                            }
                          },
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(12),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
