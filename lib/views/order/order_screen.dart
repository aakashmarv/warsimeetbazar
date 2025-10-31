import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../viewmodels/order_list_controller.dart';
import '../../widgets/custom_text_app_bar.dart';
import 'order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  final bool showAppBar;

  const OrderScreen({super.key, this.showAppBar = true});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final orderListController = Get.put(OrderListController());

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

      body: Obx(() {
        if (orderListController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orderListController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              orderListController.errorMessage.value,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey),
            ),
          );
        }

        final orders = orderListController.orders;

        return ListView.builder(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12.h),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            final orderDate = order.createdAt.split("T").first;
            final status = order.orderStatus.capitalizeFirst ?? "";
            final total = order.totalAmount.toStringAsFixed(0);
            //  final imageUrl = item.product.image.isNotEmpty
            //                         ? "${ApiConstants.imageBaseUrl}${item.product.image}"
            //                         : "assets/images/banner2.jpg";
            return InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Get.to(() => OrderDetailScreen(order: order));

                // Get.to(() => OrderDetailScreen(orderData: {'id': order.id}));
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
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Image (Placeholder)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.asset(
                          "assets/images/banner2.jpg",
                          width: 28.w,
                          height: 10.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 14),

                      /// Text Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Order Number
                            Text(
                              "Order #${order.orderNumber}",
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

                            /// Price
                            Text(
                              "₹$total",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 6),

                            /// Date + Status
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 16,
                                      color: Colors.green[700],
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      orderDate,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.green[700],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(width: 10),

                                /// Status Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    status,
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
              ),
            );
          },
        );
      }),
    );
  }
}
