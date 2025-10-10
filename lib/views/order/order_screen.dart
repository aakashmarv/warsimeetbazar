import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../widgets/custom_text_app_bar.dart';
import 'order_detail_screen.dart';


class OrderScreen extends StatefulWidget {
  final bool showAppBar;

  const OrderScreen({super.key, this.showAppBar = true});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  List<Map<String, dynamic>> orderItems = [
    {
      "name": "Fresh Indian Baasa - Bengali Cut",
      "price": 398,
      "qty": 2,
      "packs": "2 pack",
      "image": "assets/images/banner2.jpg",
      "status": "Processing",
      "deliveryTime": "Today 90 min",
    },
    {
      "name": "Premium Tender Chicken - Curry Cut",
      "price": 159,
      "qty": 1,
      "packs": "1 pack",
      "image": "assets/images/banner2.jpg",
      "status": "Shipped",
      "deliveryTime": "Tomorrow 120 min",
    },
    {
      "name": "Farm Fresh Mutton - Curry Cut",
      "price": 549,
      "qty": 1,
      "packs": "1 pack",
      "image": "assets/images/banner2.jpg",
      "status": "Delivered",
      "deliveryTime": "Yesterday",
    },
  ];

  double get totalAmount {
    return orderItems.fold<double>(
      0.0,
          (sum, item) => sum + ((item["price"] as int) * (item["qty"] as int)),
    );
  }

  int get totalItems {
    return orderItems.fold<int>(0, (sum, item) => sum + (item["qty"] as int));
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
          "My Orders",
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
          : const CustomTextAppBar(title: "Orders"),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                      left: 12, right: 12, top: 12, bottom: 12.h),
                  itemCount: orderItems.length,
                  itemBuilder: (context, index) {
                    final item = orderItems[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        // Pass full item to detail screen
                        Get.to(() => OrderDetailScreen(orderData: item));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.asset(
                                      item["image"],
                                      width: 28.w,
                                      height: 10.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["name"],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black87,
                                            height: 1.3,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Text(
                                              "₹${(item["price"] * item["qty"]).toString()}",
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              item["packs"],
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.delivery_dining,
                                              size: 16,
                                              color: Colors.green[700],
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              item["deliveryTime"],
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.green[700],
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: AppColors.primary
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                BorderRadius.circular(12),
                                              ),
                                              child: Text(
                                                item["status"],
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
