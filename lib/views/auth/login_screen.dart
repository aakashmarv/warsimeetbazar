import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, // 6% of screen width
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top navigation bar
              SizedBox(height: screenHeight * 0.08),


              // Licious Logo
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20), // fully rounded
                  child: Image.asset(
                    'assets/images/applogo.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.045),

              // Login with mobile number text
              Text(
                'Login with your mobile number',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // Mobile number input field
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!, width: 1),
                ),
                child: Row(
                  children: [
                    // Country code
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.022,
                      ),
                      child: Text(
                        '+91',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Divider line
                    Container(
                      width: 1,
                      height: screenHeight * 0.03,
                      color: Colors.grey[300],
                    ),
                    // Phone number input
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter Mobile Number',
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.022,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Spacer to push content to bottom
              Spacer(),

              // Get OTP Button
              Container(
                width: double.infinity,
                height: screenHeight * 0.065,
                child: ElevatedButton(
                  onPressed: () {
                    // Get OTP functionality
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Get OTP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              // Terms and conditions
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: screenWidth * 0.022,
                      color: Colors.grey[600],
                      height: 1.4,
                    ),
                    children: [
                      TextSpan(text: 'By logging in, you agree to our '),
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}