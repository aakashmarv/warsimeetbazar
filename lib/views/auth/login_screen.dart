import 'package:dry_fish/roots/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/app_colors.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool isValidNumber = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      if (_phoneController.text.length == 10) {
        FocusScope.of(context).unfocus(); // Close keyboard
      }
      setState(() {
        isValidNumber = _phoneController.text.length == 10;
      });
    });
  }


  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      // backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// Background Watermark Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/images/bgImages/loginBg.jpeg',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.08),

                  // Logo
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/applogo.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.045),

                  Text(
                    'Login with your mobile number',
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      color: AppColors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Phone Input
                  Container(
                    height: screenHeight * 0.065,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 0.5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                          ),
                          child: Text(
                            '+91',
                            style: TextStyle(
                              fontSize: screenWidth * 0.043,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          width: 1,
                          height: screenHeight * 0.03,
                          color: AppColors.hintTextGrey,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: "",
                              hintText: 'Enter Mobile Number',
                              hintStyle: TextStyle(
                                color: AppColors.hintTextGrey,
                                fontSize: screenWidth * 0.043,
                                fontWeight: FontWeight.w500,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.015,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Get OTP Button
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.grey.withOpacity(0.5),
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ElevatedButton(
                        onPressed: isValidNumber
                            ? () {
                          Get.toNamed(
                            AppRoutes.otpVerification,
                            arguments: {
                              "phoneNumber": "+91 ${_phoneController.text}",
                            },
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isValidNumber
                              ? AppColors.primary
                              : AppColors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Get OTP',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: screenWidth * 0.042,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.015),

                  // Terms
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.nunito(
                          fontSize: screenWidth * 0.028,
                          color: AppColors.darkGrey,
                          height: 1,
                        ),
                        children: [
                          const TextSpan(text: 'By continuing, you accept our '),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: GoogleFonts.nunito(
                              fontSize: screenWidth * 0.030,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          // const TextSpan(text: ' and '),
                          // TextSpan(
                          //   text: 'Privacy Policy',
                          //   style: GoogleFonts.nunito(
                          //     fontSize: screenWidth * 0.030,
                          //     color: AppColors.black,
                          //     fontWeight: FontWeight.w600,
                          //     decoration: TextDecoration.underline,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
