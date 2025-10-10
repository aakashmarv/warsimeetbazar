import 'package:dry_fish/Constants/app_colors.dart';
import 'package:dry_fish/roots/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NewAddressScreen extends StatelessWidget {
  const NewAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.extraLightestPrimary,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Add Address",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("NAME", "Akash"),
            _buildMobileField(),
            Row(
              children: [
                Expanded(
                  child: _buildTextField("HOUSE/FLAT NO", "Flat No"),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildTextField("BLOCK NAME (OPTIONAL)", "Block Name"),
                ),
              ],
            ),
            _buildTextField("BUILDING NAME", "Building Name"),
            _buildTextField("STREET", "Street"),
            _buildTextField("LANDMARK", "Landmark"),
            _buildTextField("PINCODE", "226012"),
            _buildTextField("LOCALITY", "L D A Colony"),
            SizedBox(height: 2.h),
            Text(
              "SAVE AS",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                _buildSaveAsButton("HOME", Icons.home, true),
                SizedBox(width: 3.w),
                _buildSaveAsButton("WORK", Icons.business_center, false),
                SizedBox(width: 3.w),
                _buildSaveAsButton("OTHER", Icons.location_on, false),
              ],
            ),
            SizedBox(height: 4.h),
            SafeArea(
              minimum: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom + 12, // adds safe padding
              ),
              child: SizedBox(
                width: double.infinity,
                height: 6.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                  ),
                  onPressed: () {

                  },
                  child: Text(
                    "SAVE ADDRESS",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
              border: const UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileField() {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "MOBILE NUMBER",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.green[800],
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.8.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(10.sp),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.flag, color: Colors.orange,size: 20,),
                    SizedBox(width: 1.w),
                    Text(
                      "+91",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "9760203435",
                    hintStyle:
                    TextStyle(fontSize: 14.sp, color: Colors.grey),
                    border: const UnderlineInputBorder(),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSaveAsButton(String text, IconData icon, bool selected) {
    return Expanded(
      child: Container(
        height: 5.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          border: Border.all(
            color: selected ? Colors.green : Colors.grey,
            width: 1,
          ),
          color: selected ? Colors.green.shade50 : Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16.sp, color: selected ? Colors.green : Colors.grey),
            SizedBox(width: 1.w),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.green : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
