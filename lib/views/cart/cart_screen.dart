import 'package:dry_fish/views/cart/widgets/floating_cart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../roots/routes.dart';
import '../../viewmodels/cart_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();

  List<Map<String, dynamic>> cartItems = [
    {
      "name":
      "Fresh Indian Baasa / Pangasius / Pangas - Bengali Cut (May include head piece)",
      "price": 398,
      "qty": 2,
      "packs": "2 pack",
      "image": "assets/images/banner2.jpg"
    },
    {
      "name":
      "Premium Tender and Antibiotic-residue-free Chicken - Curry Cut (Skinless)",
      "price": 159,
      "qty": 1,
      "packs": "1 pack",
      "image": "assets/images/banner2.jpg"
    },
    {
      "name": "Farm Fresh Mutton - Curry Cut (With Bone)",
      "price": 549,
      "qty": 1,
      "packs": "1 pack",
      "image": "assets/images/banner2.jpg"
    },
    {
      "name": "Prawns - Medium Size, Cleaned & Deveined",
      "price": 299,
      "qty": 2,
      "packs": "2 pack",
      "image": "assets/images/banner2.jpg"
    },
    {
      "name": "Rohu Fish - Bengali Cut",
      "price": 225,
      "qty": 1,
      "packs": "1 pack",
      "image": "assets/images/banner2.jpg"
    },
    {
      "name": "Country Chicken (Nattu Kozhi) - Curry Cut",
      "price": 399,
      "qty": 1,
      "packs": "1 pack",
      "image": "assets/images/banner2.jpg"
    },
    {
      "name": "Eggs - Farm Fresh Brown Eggs (Pack of 6)",
      "price": 89,
      "qty": 1,
      "packs": "1 pack",
      "image": "assets/images/banner2.jpg"
    },
  ];


  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index]["qty"] += change;
      if (cartItems[index]["qty"] < 1) {
        cartItems[index]["qty"] = 1;
      }
      cartItems[index]["packs"] = "${cartItems[index]["qty"]} pack";
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  double get totalAmount {
    return cartItems.fold<double>(
      0.0,
          (sum, item) => sum + ((item["price"] as int) * (item["qty"] as int)),
    );
  }


  int get totalItems {
    return cartItems.fold<int>(0, (sum, item) => sum + (item["qty"] as int));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "My Cart",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Stack(
        children: [
          /// Cart List
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return Container(
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
                                /// Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.asset(
                                    item["image"],
                                    width: 130,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),

                                /// Details
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
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Text(
                                            "₹${(item["price"] * item["qty"]).toString()}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            item["packs"],
                                            style: TextStyle(
                                              color: Colors.grey[500],
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.delivery_dining,
                                            size: 16,
                                            color: Colors.green[700],
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "Today 90 min",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.green[700],
                                              fontWeight: FontWeight.w500,
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

                          /// Divider
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey[200],
                          ),

                          /// Footer: Remove + Quantity
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /// Remove button
                                Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () => removeItem(index),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete_outline_rounded,
                                            color: AppColors.grey,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            "Remove",
                                            style: TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                /// Quantity Selector
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.lighterPrimary,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            updateQuantity(index, -1),
                                        icon: Icon(
                                          Icons.remove_rounded,
                                          color: item["qty"] > 1
                                              ? AppColors.primary
                                              : Colors.grey[400],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          item["qty"].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            updateQuantity(index, 1),
                                        icon: Icon(
                                          Icons.add_rounded,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
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
            ],
          ),
          /// Checkout Bottom
          // Positioned(
          //   left: 4.w,right: 4.w,
          //   bottom: 6.h,
          //   child: Container(
          //     padding: EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       color: AppColors.successGreen,
          //       borderRadius: BorderRadius.circular(12),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black26,
          //           blurRadius: 4,
          //           offset: const Offset(0, 2),
          //         )
          //       ],
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         /// Left: Items & Price
          //         Row(
          //           children: [
          //             Text(
          //               "$totalItems items |",
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //             const SizedBox(width: 8),
          //             Text(
          //               "₹${totalAmount.toStringAsFixed(0)}",
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 16,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //           ],
          //         ),
          //
          //         /// Right: Checkout button
          //         InkWell(
          //           onTap: () {
          //             // Checkout action
          //           },
          //           child: Row(
          //             children: const [
          //               Text(
          //                 "Checkout",
          //                 style: TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 16,
          //                   fontWeight: FontWeight.w600,
          //                 ),
          //               ),
          //               SizedBox(width: 4),
          //               Icon(Icons.arrow_forward,
          //                   color: Colors.white, size: 18),
          //             ],
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          FloatingCartBarWidget(
            totalItems: cartController.totalItems,
            totalPrice: cartController.totalPrice,
            buttonText: "Checkout",
            onTap: () {
              Get.toNamed(AppRoutes.Checkout);
            },
          ),
        ],
      ),
    );
  }
}
