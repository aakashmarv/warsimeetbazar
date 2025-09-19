import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.04),

              /// User Info
              Center(
                child: Column(
                  children: [
                    Text(
                      "Hi, Akash",
                      style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      "9760203435 | Aman576543@gmail.com",
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              /// Menu Items
              _buildMenuItem(context, Icons.shopping_cart_outlined,
                  "Orders", "Check your order status"),
              _buildMenuItem(context, Icons.card_giftcard,
                  "Earn Rewards", "Invite friends and earn rewards"),
              _buildMenuItem(context, Icons.phone,
                  "Contact Us", "Help regarding your recent purchase"),
              _buildMenuItem(context, Icons.description_outlined,
                  "Terms & Conditions", ""),
              _buildMenuItem(
                  context, Icons.privacy_tip, "Privacy Policy", ""),
              _buildMenuItem(
                  context, Icons.store_mall_directory, "Seller Information", ""),
              _buildMenuItem(context, Icons.lock_outline,
                  "Account Privacy", ""),
              _buildMenuItem(context, Icons.notifications_active_outlined,
                  "Notification Preferences", ""),
              _buildMenuItem(context, Icons.logout, "Logout", ""),

              SizedBox(height: screenHeight * 0.05),

              /// App Version Footer
              Center(
                child: Column(
                  children: [
                    Text(
                      "Fresh to Home",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    Text(
                      "v8.0.0.0",
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title,
      String subtitle,
      {String? trailing}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(icon, color: Colors.black87, size: screenWidth * 0.07),
          title: Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle.isNotEmpty
              ? Text(
            subtitle,
            style: TextStyle(
              fontSize: screenWidth * 0.035,
              color: Colors.grey[600],
            ),
          )
              : null,
          trailing: trailing != null
              ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.monetization_on, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text(
                trailing,
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          )
              : Icon(Icons.chevron_right, color: Colors.grey),
          onTap: () {},
        ),
        Divider(height: screenHeight * 0.01, thickness: 0.6),
      ],
    );
  }
}
