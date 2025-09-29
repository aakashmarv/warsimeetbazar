// import 'package:dry_fish/Constants/app_colors.dart';
// import 'package:dry_fish/roots/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import '../../../viewmodels/cart_controller.dart';
//
//
// class FloatingCartBar extends StatelessWidget {
//   final CartController cartController = Get.find<CartController>();
//
//   FloatingCartBar({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (cartController.totalItems.value == 0) {
//         return const SizedBox.shrink();
//       }
//
//       return Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//           margin:  EdgeInsets.only(left: 4.w,right: 4.w,bottom: 6.h),
//           padding:  EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: AppColors.successGreen,
//             borderRadius: BorderRadius.circular(12),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black26,
//                 blurRadius: 2,
//                 offset: const Offset(0, 2),
//               )
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               /// Left: Items & Price
//               Row(
//                 children: [
//                   Text(
//                     "${cartController.totalItems.value} items |",
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     "₹${cartController.totalPrice.value.toStringAsFixed(0)}",
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//
//               /// Right: Cart button
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(AppRoutes.cart);
//                 },
//                 child: Row(
//                   children: const [
//                     Text(
//                       "View cart",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     SizedBox(width: 4),
//                     Icon(Icons.arrow_forward,
//                         color: Colors.white, size: 18),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../Constants/app_colors.dart';

class FloatingCartBarWidget extends StatelessWidget {
  /// Observable item count & price
  final RxInt totalItems;
  final RxDouble totalPrice;

  /// Button text (e.g., "View cart", "Checkout")
  final String buttonText;

  /// OnTap callback
  final VoidCallback onTap;

  const FloatingCartBarWidget({
    super.key,
    required this.totalItems,
    required this.totalPrice,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (totalItems.value == 0) return const SizedBox.shrink();

      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 6.h),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.successGreen,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left: Items & Price
              Row(
                children: [
                  Text(
                    "${totalItems.value} items |",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "₹${totalPrice.value.toStringAsFixed(0)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              /// Right: Button
              InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    Text(
                      buttonText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
