import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../widgets/custom_text_app_bar.dart';

class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailScreen({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final orderItems = [
      {
        "name": orderData["name"],
        "qty": orderData["qty"],
        "price": orderData["price"],
        "packs": orderData["packs"],
        "image": orderData["image"]
      }
    ];

    final subtotal = orderItems.fold<double>(
        0.0, (sum, item) => sum + (item["price"] as int) * (item["qty"] as int));
    final deliveryCharge = 50.0;
    final discount = 30.0;
    final grandTotal = subtotal + deliveryCharge - discount;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
        appBar: AppBar(
          backgroundColor: AppColors.extraLightestPrimary,
          
          elevation: 1,
          centerTitle: true,
          title: const Text(
            "Order Detail",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Order Info
            _buildSection(
              title: "Order Info",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowInfo("Order ID", "#ORD123456"),
                  _rowInfo("Order Date", "3 Oct 2025"),
                  _rowInfo("Status", orderData["status"],
                      color: AppColors.primary),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// Customer Info
            _buildSection(
              title: "Customer Info",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowInfo("Name", "Rahul Sharma"),
                  _rowInfo("Phone", "+91 9876543210"),
                  _rowInfo("Address", "Salt Lake, Kolkata, West Bengal"),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// Items
            _buildSection(
              title: "Items",
              child: Column(
                children: List.generate(orderItems.length, (index) {
                  final item = orderItems[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            item["image"],
                            width: screenWidth * 0.24,
                            height: screenWidth * 0.20,
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
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 0.8.h),
                              Row(
                                children: [
                                  Text(
                                    "₹${item["price"] * item["qty"]}",
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    "${item["qty"]} x ${item["packs"]}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey[600],
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
                }),
              ),
            ),

            SizedBox(height: 2.h),

            /// Price Summary
            _buildSection(
              title: "Price Summary",
              child: Column(
                children: [
                  _rowInfo("Subtotal", "₹$subtotal"),
                  _rowInfo("Delivery", "₹$deliveryCharge"),
                  _rowInfo("Discount", "-₹$discount"),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  _rowInfo("Grand Total", "₹$grandTotal",
                      isBold: true, color: AppColors.primary),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            /// Payment Info
            _buildSection(
              title: "Payment Info",
              child: Column(
                children: [
                  _rowInfo("Payment Method", "UPI (Google Pay)"),
                  _rowInfo("Payment Status", "Paid", color: Colors.green),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section builder
  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )),
          SizedBox(height: 1.h),
          child,
        ],
      ),
    );
  }

  /// Row info widget
  Widget _rowInfo(String label, String value,
      {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
                color: color ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
