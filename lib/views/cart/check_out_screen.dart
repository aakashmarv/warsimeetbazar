import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
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
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            SizedBox(height: 2.h),

            /// Order Summary Header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Order Summary",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 1.h),

            /// Delivery Slot
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "30th Sep, Tue : 8:00am - 12:00pm",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.green[800],
                ),
              ),
            ),
            SizedBox(height: 2.h),

            /// Cart Items List
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => Divider(
                  height: 1,
                  color: Colors.grey[300],
                ),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Image
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

                        /// Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                "Qty: ${item["qty"]}",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "₹${item["price"]}",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              "₹${item["originalPrice"]}",
                              style: TextStyle(
                                fontSize: 14.sp,
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

            /// Price Details
            Column(
              children: [
                Divider(color: Colors.grey[300]),
                SizedBox(height: 1.h),
                priceRow("Item Subtotal (Inc. of GST)", subtotal),
                SizedBox(height: 0.5.h),
                priceRow("Shipping", shippingFee),
                SizedBox(height: 0.5.h),
                priceRow("Handling Fee", handlingFee),
                Divider(color: Colors.grey[300]),
                SizedBox(height: 1.h),
                priceRow(
                  "Total Amount",
                  totalAmount,
                  isBold: true,
                  color: Colors.green[700],
                ),
                SizedBox(height: 0.5.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "You are saving ₹${cartItems.fold(0.0, (sum, item) => sum + ((item["originalPrice"] - item["price"]) * item["qty"]))} on this order",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ],
        ),
      ),

      /// Floating Place Order Bar
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        height: 6.h,
        color: Colors.transparent,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            // Place Order action
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$totalItems Items | ₹${totalAmount.toStringAsFixed(0)}",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500,color: AppColors.white),
              ),
              Text(
                "Place Order",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600,color: AppColors.white),
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
            fontSize: 14.sp,
            color: Colors.grey[800],
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          "₹${value.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: color ?? Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
