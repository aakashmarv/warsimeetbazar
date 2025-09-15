import 'package:dry_fish/roots/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MediaQuery for responsive design
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Dummy data
    final String orderId = "ORD123456789";
    final List<Map<String, dynamic>> orderItems = [
      {"name": "Fresh Chicken", "quantity": 2, "price": 350},
      {"name": "Organic Eggs", "quantity": 1, "price": 120},
      {"name": "Farm Fresh Milk", "quantity": 3, "price": 180},
    ];
    final String estimatedDelivery = "Today 6:30 PM";

    return Scaffold(
      body: Stack(
        children: [
          // Full-screen Lottie confetti background
          SizedBox(
            height: screenHeight,
            width: screenWidth,
            child: Lottie.asset(
              'assets/animations/confeti.json', // Replace with your confetti Lottie file
              fit: BoxFit.cover,
              repeat: false,
            ),
          ),

          // Optional semi-transparent overlay for readability
          // Container(
          //   height: screenHeight,
          //   width: screenWidth,
          //   color: Colors.black.withOpacity(0.2),
          // ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.05),

                // Animated Checkmark
                Lottie.asset(
                  'assets/animations/successfuldone.json',
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  repeat: false,
                ),
                SizedBox(height: screenHeight * 0.02),

                // Confirmation Message
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

                // Order Details Card
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
                          // Order ID
                          Text(
                            "Order ID: $orderId",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),

                          // Order Summary
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

                          Divider(height: screenHeight * 0.03, thickness: 1),

                          // Estimated Delivery
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                Spacer(),

                // Track Order Button
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05,
                      vertical: screenHeight * 0.03),
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
    );
  }
}
