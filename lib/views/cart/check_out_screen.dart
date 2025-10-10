import 'package:dry_fish/roots/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems = [
    {
      "name":
      "Fresh Indian Baasa / Pangasius / Pangas - Bengali Cut (May include head piece) (480g to 500g Pack) (Whole Fish 1kg to 3kg)",
      "price": 398,
      "originalPrice": 582,
      "qty": 2,
      "image": "assets/images/banner2.jpg",
    },
    {
      "name":
      "Premium Tender and Antibiotic-residue-free Chicken - Curry Cut (Skinless) (450g Pack)",
      "price": 159,
      "originalPrice": 224,
      "qty": 1,
      "image": "assets/images/banner2.jpg",
    },
  ];

  final double shippingFee = 29;
  final double handlingFee = 4;

  CheckoutScreen({super.key});

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item["price"] * item["qty"]));

  double get totalAmount => subtotal + shippingFee + handlingFee;

  int get totalItems =>
      cartItems.fold(0, (sum, item) => sum + (item["qty"] as int));

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),

            /// Delivery Address Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderGrey,
                width: 1)
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
                            fontSize: 14.sp,
                            color: Colors.grey[600],
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
                  )
                ],
              ),
            ),
            SizedBox(height: 2.h),

            /// Order Summary Header
            Text(
              "Order Summary",
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 1.h),

            /// Cart Items List
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, color: Colors.grey[300]),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item["image"],
                            width: 22.w,
                            height: 8.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "Qty: ${item["qty"]}",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "₹${item["price"]}",
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              "₹${item["originalPrice"]}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            /// Price Details Card
            Container(
              padding: EdgeInsets.all(3.w),
              margin: EdgeInsets.only(top: 1.h, bottom: 2.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  priceRow("Item Subtotal (Inc. of GST)", subtotal),
                  SizedBox(height: 0.8.h),
                  priceRow("Shipping", shippingFee),
                  SizedBox(height: 0.8.h),
                  priceRow("Handling Fee", handlingFee),
                  Divider(color: Colors.grey[300]),
                  priceRow(
                    "Total Amount",
                    totalAmount,
                    isBold: true,
                    color: Colors.green[700],
                  ),
                  SizedBox(height: 0.8.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "You are saving ₹${cartItems.fold(0.0, (sum, item) => sum + ((item["originalPrice"] - item["price"]) * item["qty"]))} on this order",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      /// Floating Place Order Bar
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 4.h, left: 4.w, right: 4.w),
        height: 6.5.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Get.toNamed(AppRoutes.orderConfirmer);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$totalItems Items | ₹${totalAmount.toStringAsFixed(0)}",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Text(
                "Place Order",
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget priceRow(String title, double value,
      {bool isBold = false, Color? color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.grey[800],
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
