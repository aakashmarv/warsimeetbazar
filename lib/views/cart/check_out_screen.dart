import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../constants/api_constants.dart';
import '../../constants/app_keys.dart';
import '../../models/requests/place_order_request.dart';
import '../../services/sharedpreferences_service.dart';
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

  final orderController = Get.put(PlaceOrderController());
  final cartController = Get.find<CartItemController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => cartController.fetchItems(),
    );
  }

  double get subtotal =>
      cartController.cartItems.fold(0.0, (sum, item) => sum + (item.total ?? 0.0));

  double get totalAmount => subtotal + shippingFee + handlingFee;

  int get totalItems =>
      cartController.cartItems.fold(0, (sum, item) => sum + (item.quantity ?? 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.extraLightestPrimary,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (cartController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = cartController.cartItems;
        if (items.isEmpty) {
          return const Center(
            child: Text(
              "Your cart is empty",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 1.h),

                    /// 🛒 Cart Items
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) =>
                            Divider(height: 1, color: Colors.grey[300]),
                        itemBuilder: (_, i) {
                          final item = items[i];
                          final imageUrl = (item.product?.image?.isNotEmpty ?? false)
                              ? "${ApiConstants.imageBaseUrl}${item.product?.image}"
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
                                        const Icon(Icons.image, size: 40),
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.product?.name ?? '',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(height: 0.5.h),
                                      Text(
                                        "${item.product?.name ?? ''} | ${item.product?.weight ?? ''}",
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
                                            "₹${(item.total ?? 0.0).toStringAsFixed(0)}",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
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

                    /// 💰 Totals
                    Container(
                      padding: EdgeInsets.all(3.w),
                      margin: EdgeInsets.only(top: 1.h, bottom: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _priceRow("Item Subtotal", subtotal),
                          _priceRow("Shipping", shippingFee),
                          _priceRow("Handling Fee", handlingFee),
                          const Divider(),
                          _priceRow(
                            "Total Amount",
                            totalAmount,
                            isBold: true,
                            color: Colors.green[700],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              /// 🟢 Floating Place Order Button
              Positioned(
                bottom: 10,
                left: 16,
                right: 16,
                child: SafeArea(
                  child: Obx(() {
                    final tItems = totalItems;
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: EdgeInsets.symmetric(vertical: 1.6.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: orderController.isLoading.value
                          ? null
                          : () async {
                              if (cartController.cartItems.isEmpty) return;
                              // ✅ Fetch saved latitude & longitude from SharedPreferences
                              final prefs = await SharedPreferencesService.getInstance();
                              final latitude = prefs.getDouble(AppKeys.latitude);
                              final longitude = prefs.getDouble(AppKeys.longitude);
                              print("📍 Current Location request: "
                                  "Lat=${latitude}, Lng=${longitude}");


                              final firstItem = cartController.cartItems.first;
                              final request = PlaceOrderRequest(
                                userId: firstItem.userId,
                                recipientName: "John Doe",
                                recipientPhone: "9876543210",
                                deliveryAddress: "123 Green Street, MG Road",
                                deliveryCity: "Mumbai",
                                deliveryState: "Maharashtra",
                                deliveryPostcode: "400001",
                                totalAmount: totalAmount,
                                paymentStatus: "paid",
                                orderStatus: "dispatched",
                                notes: "Handle with care. Deliver before 6 PM.",
                                dispatchedAt: "2025-10-08T14:30:00",
                                deliveredAt: null,
                                latitude: latitude,
                                longitude: longitude,
                              );

                              await orderController.placeOrderCont(request);
                            },
                      child: orderController.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$tItems Items | ₹${totalAmount.toStringAsFixed(0)}",
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
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _priceRow(
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
          "₹${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: color ?? Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
