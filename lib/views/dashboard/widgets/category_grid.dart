import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../constants/api_constants.dart';
import '../../../Constants/app_colors.dart';
import '../../../roots/routes.dart';
import '../../../viewmodels/category_controller.dart';

class CategoryGrid extends StatelessWidget {
  final CategoryController controller;
  const CategoryGrid({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmer(w, h);
      } else if (controller.categoryList.isEmpty) {
        return Center(child: Text("No categories found"));
      } else {
        return GridView.builder(
          padding: EdgeInsets.only(top: 10),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.categoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: w * 0.02,
            mainAxisSpacing: h * 0.015,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (_, i) {
            final category = controller.categoryList[i];
            final imageUrl = category.image != null
                ? "${ApiConstants.imageBaseUrl}/${category.image}"
                : "assets/images/p2.png";

            return InkWell(
              onTap: () {
                if (category.id != null) {
                  Get.toNamed(AppRoutes.productScreen,
                      arguments: {'categoryId': category.id});
                } else {
                  Get.snackbar("Error", "Invalid category ID");
                }
              },
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      imageUrl,
                      height: w * 0.18,
                      width: w * 0.18,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Image.asset(
                        "assets/images/p2.png",
                        height: w * 0.18,
                        width: w * 0.18,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.008),
                  Text(category.name ?? "",
                  maxLines: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                          fontSize: w * 0.030,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black)),
                ],
              ),
            );
          },
        );
      }
    });
  }

  Widget _buildShimmer(double w, double h) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 8,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4,
      crossAxisSpacing: w * 0.02,
      mainAxisSpacing: h * 0.015,
      childAspectRatio: 0.75,
    ),
    itemBuilder: (_, __) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          Container(
            height: w * 0.18,
            width: w * 0.18,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
          SizedBox(height: h * 0.008),
          Container(
            height: h * 0.02,
            width: w * 0.18,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}
