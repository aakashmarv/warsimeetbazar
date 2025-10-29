import 'package:dry_fish/roots/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../constants/api_constants.dart';
import '../../viewmodels/placeorder_controller.dart';
import '../../viewmodels/cart_item_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final double shippingFee = 29;
  final double handlingFee = 4;

  final PlaceOrderController orderController = Get.put(PlaceOrderController());

  final CartItemController cartItemController = Get.put(CartItemController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartItemController.fetchItems();
    });
  }

  double subtotal() =>
      cartItemController.cartItems.fold(0, (sum, item) => sum + item.total);

  int totalItems() =>
      cartItemController.cartItems.fold(0, (sum, item) => sum + item.quantity);

  double totalAmount() => subtotal() + shippingFee + handlingFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),

      body: Obx(() {
        if (cartItemController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (cartItemController.cartItems.isEmpty) {
          return const Center(
            child: Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        final items = cartItemController.cartItems;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),

              /// ✅ Delivery Address (Not Removed / Not Changed)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderGrey, width: 1),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 22.sp),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Address",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            "John Doe, 221B Baker Street, Near Metro Station, Bengaluru, Karnataka - 560001",
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.newAddress);
                      },
                      child: Text(
                        "Change",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.green[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 2.h),
              Text(
                "Order Summary",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 1.h),

              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) =>
                      Divider(height: 1, color: Colors.grey[300]),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final imageUrl = item.product.image.isNotEmpty
                        ? "${ApiConstants.imageBaseUrl}${item.product.image}"
                        : "assets/images/banner2.jpg";

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              imageUrl,
                              width: 22.w,
                              height: 8.h,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image, size: 45),
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.product.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  "${item.product} | ${item.product.weight}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Qty: ${item.quantity}",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Text(
                                      "₹${item.total.toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 15.sp,
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
                  },
                ),
              ),

              /// ✅ Price Details Section
              Container(
                padding: EdgeInsets.all(3.w),
                margin: EdgeInsets.only(top: 1.h, bottom: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                ),
                child: Column(
                  children: [
                    priceRow("Item Subtotal", subtotal()),
                    priceRow("Shipping", shippingFee),
                    priceRow("Handling Fee", handlingFee),
                    const Divider(),
                    priceRow(
                      "Total Amount",
                      totalAmount(),
                      isBold: true,
                      color: Colors.green[700],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),

      /// ✅ Place Order Button
      bottomNavigationBar: Obx(() {
        final tItems = totalItems();
        final total = totalAmount();

        return Container(
          margin: EdgeInsets.only(bottom: 4.h, left: 4.w, right: 4.w),
          height: 6.5.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              if (cartItemController.cartItems.isEmpty) return;

              await orderController.placeOrder();

              if (orderController.orderResponse.value != null) {
                cartItemController.cartItems.clear();
                Get.toNamed(AppRoutes.orderConfirmer);
              } else {
                Get.snackbar(
                  "Error",
                  orderController.errorMessage.value,
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.redAccent,
                  colorText: Colors.white,
                );
              }
            },
            child: orderController.isLoading.value
                ? const CircularProgressIndicator(color: Colors.white)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$tItems Items | ₹${total.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Place Order",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      }),
    );
  }

  Widget priceRow(
    String title,
    double value, {
    bool isBold = false,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          "₹${value.toStringAsFixed(0)}",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: color,
          ),
        ),
      ],
    );
  }
}
