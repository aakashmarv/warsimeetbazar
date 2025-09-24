import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../Constants/app_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),

              /// User Info
              Center(
                child: Column(
                  children: [
                    Text(
                      "Hi, Akash",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      "9760203435 | Aman576543@gmail.com",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 3.h),

              /// Menu Items
              _buildMenuItem(
                icon: Icons.shopping_cart_outlined,
                title: "Orders",
                subtitle: "Check your order status",
              ),
              _buildMenuItem(
                icon: Icons.card_giftcard,
                title: "Earn Rewards",
                subtitle: "Invite friends and earn rewards",
              ),
              _buildMenuItem(
                icon: Icons.phone_outlined,
                title: "Contact Us",
                subtitle: "Help regarding your recent purchase",
              ),
              _buildMenuItem(
                icon: Icons.description_outlined,
                title: "Terms & Conditions",
                subtitle: "",
              ),
              _buildMenuItem(
                icon: Icons.policy_outlined,
                title: "Privacy Policy",
                subtitle: "",
              ),
              _buildMenuItem(
                icon: Icons.store_outlined,
                title: "Seller Information",
                subtitle: "",
              ),
              _buildMenuItem(
                icon: Icons.lock_outline,
                title: "Account Privacy",
                subtitle: "",
              ),
              _buildMenuItem(
                icon: Icons.notifications_active_outlined,
                title: "Notification Preferences",
                subtitle: "",
              ),
              _buildMenuItem(
                icon: Icons.logout,
                title: "Logout",
                subtitle: "",
              ),

              SizedBox(height: 5.h),

              /// App Version Footer
              Center(
                child: Column(
                  children: [
                    /// First line with styled text
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.nunito(
                          fontSize: 20.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "CHAVAN ",
                            style: const TextStyle(color: AppColors.black),
                          ),
                          TextSpan(
                            text: "BROTHER'S",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ],
                      ),
                    ),

                    /// Second line - all caps
                    Text(
                      "GROUP OF JEEVAN AGRO",
                      style: GoogleFonts.nunito(
                        fontSize: 12.sp,
                        color: Colors.black,
                        letterSpacing: 1, // makes it look more formal
                      ),
                    ),

                    SizedBox(height: 0.5.h),

                    /// Version text
                    Text(
                      "v8.0.0.0",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height:2.h),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    String? trailing,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: AppColors.primary, size: 20.sp),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle.isNotEmpty
              ? Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          )
              : null,
          trailing: trailing != null
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.monetization_on,
                  color: Colors.amber, size: 14.sp),
              SizedBox(width: 1.w),
              Text(
                trailing,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
              : Icon(Icons.chevron_right, color: AppColors.darkGrey, size: 18.sp),
          onTap: () {},
        ),
        Divider(height: 1.h, thickness: 0.3,color: AppColors.grey,),
      ],
    );
  }
}
