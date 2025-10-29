import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../models/static responses/saved_address_response.dart';
import '../../roots/routes.dart';
import '../../viewmodels/static data controllers/saved_address_controller.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedAddressController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        title: Text(
          "Saved Addresses",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColors.white, width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(0, 4.h),
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                backgroundColor: AppColors.primary,
              ),
              onPressed: () => Get.toNamed(AppRoutes.newAddress),
              child: Text(
                "+ Add New",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.addresses.isEmpty) {
          return const Center(
            child: Text(
              "No saved addresses found",
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          itemCount: controller.addresses.length,
          itemBuilder: (_, index) {
            return _addressCard(controller.addresses[index]);
          },
        );
      }),
    );
  }

  Widget _addressCard(AddressModel model) {
    IconData icon = model.typeIcon == "home"
        ? Icons.home_outlined
        : model.typeIcon == "city"
        ? Icons.location_city_outlined
        : Icons.location_on_outlined;

    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 2.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 0.7),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18.sp, color: Colors.black87),
          SizedBox(width: 3.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 0.4.h),
                Text(
                  model.address,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
                SizedBox(height: 0.4.h),
                Text(
                  model.phone,
                  style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),

          Icon(Icons.more_vert, color: Colors.grey[600], size: 18.sp),
        ],
      ),
    );
  }
}
