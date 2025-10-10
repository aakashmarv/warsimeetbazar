import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../Constants/app_colors.dart';
import '../../widgets/custom_text_app_bar.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CustomTextAppBar(title: "Contact Us"),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Logo
            Container(
              height: 14.h,
              width: 14.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.extraLightestPrimary,
              ),
              child: Icon(Icons.support_agent,
                  size: 40.sp, color: AppColors.primary),
            ),
            SizedBox(height: 2.h),

            Text(
              "We’re here to help!",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              "If you have any questions or need support, feel free to reach us.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey[700],
              ),
            ),

            SizedBox(height: 3.h),

            /// Contact Options
            _contactTile(
              icon: Icons.call,
              title: "Call Us",
              value: "+91 98765 43210",
              onTap: () {},
            ),
            _contactTile(
              icon: Icons.email_outlined,
              title: "Email",
              value: "support@fishmart.com",
              onTap: () {},
            ),
            _contactTile(
              icon: Icons.whatshot,
              title: "WhatsApp",
              value: "+91 98765 43210",
              onTap: () {},
            ),
            _contactTile(
              icon: Icons.location_on_outlined,
              title: "Address",
              value: "Salt Lake, Kolkata, West Bengal",
              onTap: () {},
            ),

            SizedBox(height: 4.h),

            /// Contact Form
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Send us a message",
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            SizedBox(height: 2.h),

            _inputField(label: "Name"),
            SizedBox(height: 1.5.h),
            _inputField(label: "Email"),
            SizedBox(height: 1.5.h),
            _inputField(label: "Message", maxLines: 4),

            SizedBox(height: 3.h),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 1.6.h),
                ),
                onPressed: () {
                  // TODO: handle submit
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Contact Tile
  Widget _contactTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.5.h),
      padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 3.w),
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
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.extraLightestPrimary,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primary, size: 18.sp),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87)),
                SizedBox(height: 0.3.h),
                Text(value,
                    style: TextStyle(
                        fontSize: 10.sp, color: Colors.grey[700])),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios,
              size: 14.sp, color: Colors.grey[500]),
        ],
      ),
    );
  }

  /// Input Field
  Widget _inputField({required String label, int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
