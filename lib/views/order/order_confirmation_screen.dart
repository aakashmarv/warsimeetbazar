import 'package:dry_fish/roots/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Dummy data
    const String orderId = "ORD123456789";
    final List<Map<String, dynamic>> orderItems = [
      {"name": "Fresh Chicken", "quantity": 2, "price": 350},
      {"name": "Organic Eggs", "quantity": 1, "price": 120},
      {"name": "Farm Fresh Milk", "quantity": 3, "price": 180},
    ];
    const String estimatedDelivery = "Today 6:30 PM";

    return WillPopScope(
      onWillPop: () async {
        // Navigate to dashboard on back press
        Get.offAllNamed(AppRoutes.dashBoard);
        return false; // Prevent default pop
      },
      child: Scaffold(
        body: Stack(
          children: [
            /// 🎉 Full-screen confetti animation
            SizedBox(
              height: screenHeight,
              width: screenWidth,
              child: Lottie.asset(
                'assets/animations/confeti.json',
                fit: BoxFit.cover,
                repeat: false,
              ),
            ),

            /// 🧾 Main Content
            SafeArea(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),

                  /// ✅ Success animation
                  Lottie.asset(
                    'assets/animations/successfuldone.json',
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    repeat: false,
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  /// 🟢 Confirmation title
                  Text(
                    "Order Confirmed!",
                    style: TextStyle(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    "Your order has been successfully placed.",
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  /// 📦 Order details card
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 6,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order ID: $orderId",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.045,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            Text(
                              "Order Summary",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.045,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.015),

                            ...orderItems.map((item) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * 0.005),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${item['name']} x${item['quantity']}",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                    Text(
                                      "₹${item['price']}",
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),

                            Divider(
                                height: screenHeight * 0.03, thickness: 1),

                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Estimated Delivery",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.045,
                                  ),
                                ),
                                Text(
                                  estimatedDelivery,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.045,
                                    color: Colors.green[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// 🚚 Track Order Button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.orderTracking);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Track Your Order",
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }
}
