import 'package:dry_fish/views/auth/login_screen.dart';
import 'package:dry_fish/views/auth/otp_verification_screen.dart';
import 'package:dry_fish/views/dashboard/dasboard_screen.dart';
import 'package:dry_fish/views/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const otpVerification = '/otpVerification';
  static const dashBoard = '/dashBoard';

  static const _defaultTransition = Transition.cupertino;
  static const _transitionDuration = Duration(milliseconds: 500);

  static GetPage _buildPage({
    required String name,
    required GetPageBuilder page,
  }) {
    return GetPage(
      name: name,
      page: page,
      transition: _defaultTransition,
      transitionDuration: _transitionDuration,
    );
  }

  static List<GetPage> getRoutes() {
    return [
      _buildPage(name: splash, page: () => SplashScreen()),
      _buildPage(name: login, page: () => LoginScreen()),
      _buildPage(name: otpVerification, page: () {final args = Get.arguments as Map<String, dynamic>;return OtpVerificationScreen(phoneNumber: args['phoneNumber']);},),
      _buildPage(name: dashBoard, page: () => DashboardScreen())


    ];
  }
}
