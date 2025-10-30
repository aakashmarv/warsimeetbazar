import 'package:dry_fish/views/cart/widgets/floating_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../constants/api_constants.dart';
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
  final RemoveCartItemController removeCartItemController = Get.put(RemoveCartItemController(),);
  final ReduceQuantityController reduceQuantityController = Get.put(ReduceQuantityController());
  final IncreaseQuantityController increaseQuantityController = Get.put(IncreaseQuantityController());

  @override
  void initState() {
    super.initState();
    // ✅ Call API when screen loads
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
          /// 🔹 Show Loader
          return const Center(child: CircularProgressIndicator());
        }

        if (cartitemController.errorMessage.isNotEmpty) {
          /// 🔹 Show Error Message
          return Center(
            child: Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final cartItems = cartitemController.cartItems;

        if (cartItems.isEmpty) {
          /// 🔹 Empty Cart Message
          return const Center(
            child: Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        /// 🔹 Cart List
        return Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 12,
                      bottom: 12.h,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final imageUrl = item.product.image.isNotEmpty
                          ? "${ApiConstants.imageBaseUrl}${item.product.image}"
                          : "assets/images/banner2.jpg";
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.network(
                                      imageUrl,
                                      width: 130,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          const Icon(Icons.image, size: 50),
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.product.name}",
                                          // \n(ID: ${item.product.id})",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          // "${item.product. ?? ''} |
                                          " ${item.product.weight ?? ''}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "₹${item.total.toStringAsFixed(2)}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Divider(height: 1, thickness: 1),

                            /// Quantity + Remove
                            Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
 

                                  
                                  TextButton.icon(
                                    onPressed: () async {
                                      final id = item.id.toString();
                                      await removeCartItemController
                                          .removeCartItem(id);

                                      if (removeCartItemController
                                          .successMessage
                                          .isNotEmpty) {
                                        ToastUtil.showSuccess(removeCartItemController.successMessage.value);
                                        cartitemController
                                            .fetchItems();
                                      } else if (removeCartItemController
                                          .errorMessage
                                          .isNotEmpty) {
                                        ToastUtil.showError(removeCartItemController.errorMessage.value);
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      size: 18,
                                    ),
                                    label: const Text("Remove"),
                                  ),

                                  /// Quantity selector
                                  Row(
                                    children: [

                                      IconButton(
                                        onPressed: () async {
                                          final id = item.id.toString();
                                          await reduceQuantityController
                                              .reduceQuantity(id);

                                          if (reduceQuantityController
                                              .isSuccess
                                              .isTrue) {
                                            ToastUtil.showSuccess(reduceQuantityController
                                                .message
                                                .value);
                                            cartitemController
                                                .fetchItems();
                                          } else {
                                            ToastUtil.showError(reduceQuantityController
                                                .message
                                                .value);
                                          }
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      Text("${item.quantity}"),

                                      IconButton(
                                        onPressed: () async {
                                          final id = item.id.toString();
                                          await increaseQuantityController
                                              .increaseQuantity(id);

                                          if (increaseQuantityController
                                              .isSuccess
                                              .isTrue) {
                                            ToastUtil.showSuccess(increaseQuantityController
                                                .message
                                                .value);
                                            cartitemController
                                                .fetchItems();
                                          } else {
                                            ToastUtil.showError(increaseQuantityController
                                                .message
                                                .value);
                                          }
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                  
                                  
                                    ],
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
              ],
            ),

            /// 🔹 Checkout Bottom Bar
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
}
