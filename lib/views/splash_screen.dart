import 'dart:async';
import 'package:dry_fish/Constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_keys.dart';
import '../roots/routes.dart';
import '../services/sharedpreferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
    _initialize();
  }

  Future<void> _initialize() async {
    final prefs = await SharedPreferencesService.getInstance();

    bool isLogged = prefs.getBool(AppKeys.isLogin) ?? false;

    await Future.delayed(const Duration(seconds: 3));

    if (!isLogged) {
      Get.offAllNamed(AppRoutes.dashBoard);
    }  else {
      Get.offAllNamed(AppRoutes.dashBoard);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageSize = screenWidth * 0.60; // 60% of screen width

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background watermark image with fade-in
          FadeTransition(
            opacity: _fadeAnimation,
            child: Image.asset(
              'assets/images/bgImages/splashBg.jpeg',
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(imageSize * 0.25),
                  child: Image.asset(
                    'assets/images/splashlogo.png',
                    height: imageSize,
                    width: imageSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'dart:async';
// import 'package:dry_fish/Constants/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import '../constants/app_keys.dart';
// import '../roots/routes.dart';
// import '../services/sharedpreferences_service.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initialize();
//   }
//
//   Future<void> _initialize() async {
//     final prefs = await SharedPreferencesService.getInstance();
//     bool isLogged = prefs.getBool(AppKeys.isLogin) ?? false;
//
//     await Future.delayed(const Duration(seconds: 3));
//
//     if (!isLogged) {
//       Get.offAllNamed(AppRoutes.login);
//     } else {
//       // change to dashboard if needed
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size; // screen size le liya
//
//     return Scaffold(
//       backgroundColor: AppColors.bgColor,
//       body: Lottie.asset(
//         'assets/animations/splash.json',
//         width: size.width,
//         height: size.height,
//         fit: BoxFit.contain, // pura screen ke andar fit karega (crop nahi hoga)
//       ),
//     );
//   }
// }




/// animation
// import 'dart:async';
// import 'dart:math' as math;
// import 'package:dry_fish/Constants/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../constants/app_keys.dart';
// import '../roots/routes.dart';
// import '../services/sharedpreferences_service.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   late AnimationController _waveController;
//   late AnimationController _fishController;
//   late AnimationController _logoController;
//   late AnimationController _textController;
//   late AnimationController _bubblesController;
//
//   late Animation<double> _waveAnimation;
//   late Animation<double> _fishSwimAnimation;
//   late Animation<double> _logoScaleAnimation;
//   late Animation<Offset> _logoSlideAnimation;
//   late Animation<double> _textFadeAnimation;
//   late Animation<double> _bubblesAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Wave animation for ocean effect
//     _waveController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );
//
//     // Fish swimming animation
//     _fishController = AnimationController(
//       duration: const Duration(seconds: 4),
//       vsync: this,
//     );
//
//     // Logo entrance animation
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );
//
//     // Text animation
//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
//
//     // Bubbles animation
//     _bubblesController = AnimationController(
//       duration: const Duration(seconds: 6),
//       vsync: this,
//     );
//
//     _waveAnimation = Tween<double>(
//       begin: 0,
//       end: 2 * math.pi,
//     ).animate(CurvedAnimation(
//       parent: _waveController,
//       curve: Curves.linear,
//     ));
//
//     _fishSwimAnimation = Tween<double>(
//       begin: -1.5,
//       end: 1.5,
//     ).animate(CurvedAnimation(
//       parent: _fishController,
//       curve: Curves.easeInOut,
//     ));
//
//     _logoScaleAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.elasticOut,
//     ));
//
//     _logoSlideAnimation = Tween<Offset>(
//       begin: const Offset(0, -0.5),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _logoController,
//       curve: Curves.easeOutBack,
//     ));
//
//     _textFadeAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _textController,
//       curve: Curves.easeIn,
//     ));
//
//     _bubblesAnimation = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(
//       parent: _bubblesController,
//       curve: Curves.easeInOut,
//     ));
//
//     _startAnimations();
//     _initialize();
//   }
//
//   void _startAnimations() async {
//     // Start wave animation (continuous)
//     _waveController.repeat();
//
//     // Start bubbles animation
//     _bubblesController.repeat();
//
//     // Start fish swimming (back and forth)
//     _fishController.repeat(reverse: true);
//
//     // Logo entrance after delay
//     await Future.delayed(const Duration(milliseconds: 300));
//     _logoController.forward();
//
//     // Text fade in after logo
//     await Future.delayed(const Duration(milliseconds: 600));
//     _textController.forward();
//   }
//
//   Future<void> _initialize() async {
//     final prefs = await SharedPreferencesService.getInstance();
//     bool isLogged = prefs.getBool(AppKeys.isLogin) ?? false;
//
//     await Future.delayed(const Duration(seconds: 4));
//
//     if (!isLogged) {
//       Get.offAllNamed(AppRoutes.login);
//     } else {
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }
//
//   @override
//   void dispose() {
//     _waveController.dispose();
//     _fishController.dispose();
//     _logoController.dispose();
//     _textController.dispose();
//     _bubblesController.dispose();
//     super.dispose();
//   }
//
//   Widget _buildFish(double x, double y, double size, Color color, {bool flipHorizontal = false}) {
//     return Positioned(
//       left: x,
//       top: y,
//       child: Transform.scale(
//         scaleX: flipHorizontal ? -1 : 1,
//         child: Container(
//           width: size,
//           height: size * 0.6,
//           child: CustomPaint(
//             painter: FishPainter(color),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBubble(double x, double y, double size, double opacity) {
//     return Positioned(
//       left: x,
//       top: y,
//       child: Opacity(
//         opacity: opacity,
//         child: Container(
//           width: size,
//           height: size,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: Colors.white.withOpacity(0.3),
//             border: Border.all(
//               color: Colors.blue.withOpacity(0.2),
//               width: 1,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//     final logoSize = screenWidth * 0.32;
//
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//             color: AppColors.white
//         ),
//         child: Stack(
//           children: [
//             // Animated wave background
//             AnimatedBuilder(
//               animation: _waveController,
//               builder: (context, child) {
//                 return Positioned(
//                   bottom: 0,
//                   left: 0,
//                   right: 0,
//                   height: screenHeight * 0.3,
//                   child: CustomPaint(
//                     painter: WavePainter(_waveAnimation.value),
//                     size: Size(screenWidth, screenHeight * 0.3),
//                   ),
//                 );
//               },
//             ),
//
//             // Animated bubbles
//             AnimatedBuilder(
//               animation: _bubblesController,
//               builder: (context, child) {
//                 return Stack(
//                   children: List.generate(12, (index) {
//                     final x = (screenWidth * 0.1) + (index * screenWidth * 0.07);
//                     final baseY = screenHeight * 0.8;
//                     final y = baseY - (_bubblesAnimation.value * screenHeight * 0.6) - (index * 20);
//                     final size = 8.0 + (index % 3) * 4;
//                     final opacity = math.sin(_bubblesAnimation.value * math.pi + index).abs() * 0.7;
//
//                     return (y > -50) ? _buildBubble(x, y, size, opacity) : Container();
//                   }),
//                 );
//               },
//             ),
//
//             // Swimming fish
//             AnimatedBuilder(
//               animation: _fishController,
//               builder: (context, child) {
//                 return Stack(
//                   children: [
//                     // Small fish swimming right
//                     _buildFish(
//                       screenWidth * 0.1 + (_fishSwimAnimation.value * screenWidth * 0.3),
//                       screenHeight * 0.25,
//                       30,
//                       Colors.orange.withOpacity(0.8),
//                     ),
//                     // Medium fish swimming left
//                     _buildFish(
//                       screenWidth * 0.8 + (_fishSwimAnimation.value * -screenWidth * 0.3),
//                       screenHeight * 0.4,
//                       40,
//                       Colors.yellow.withOpacity(0.8),
//                       flipHorizontal: true,
//                     ),
//                     // Small fish group
//                     _buildFish(
//                       screenWidth * 0.2 + (_fishSwimAnimation.value * screenWidth * 0.25),
//                       screenHeight * 0.35,
//                       25,
//                       Colors.lightBlue.withOpacity(0.7),
//                     ),
//                   ],
//                 );
//               },
//             ),
//
//             // Main content
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(screenWidth * 0.05),
//                     child: Image.asset(
//                       'assets/images/splashlogo.png',
//                       height: screenHeight * 0.20,
//                       width: screenWidth * 0.45,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//
//                   // Animated company text with fish theme
//                   FadeTransition(
//                     opacity: _textFadeAnimation,
//                     child: Column(
//                       children: [
//                         ShaderMask(
//                           shaderCallback: (bounds) => LinearGradient(
//                             colors: [
//                               Colors.red.shade700,
//                               Colors.red.shade500,
//                               Colors.orange.shade600,
//                             ],
//                           ).createShader(bounds),
//                           child: const Text(
//                             'CHAVAN BROTHERS',
//                             style: TextStyle(
//                               fontSize: 26,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                               letterSpacing: 2,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           'GROUP OF JEEVAN AGRO',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.blue.shade700,
//                             letterSpacing: 1.2,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'SINCE 1980',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.red.shade600,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   const SizedBox(height: 50),
//
//                   // Ocean-themed loading indicator
//                   FadeTransition(
//                     opacity: _textFadeAnimation,
//                     child: Column(
//                       children: [
//                         Text(
//                           'Loading Fresh Seafood...',
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.blue.shade600,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         SizedBox(
//                           width: 140,
//                           child: LinearProgressIndicator(
//                             backgroundColor: Colors.blue.shade100,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               Colors.blue.shade600,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                             minHeight: 6,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Floating fish icons in corners
//             AnimatedBuilder(
//               animation: _fishController,
//               builder: (context, child) {
//                 return Positioned(
//                   top: 60 + 10 * math.sin(_fishSwimAnimation.value * math.pi),
//                   right: 30,
//                   child: Opacity(
//                     opacity: 0.6,
//                     child: Text(
//                       '🐠',
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 );
//               },
//             ),
//
//             AnimatedBuilder(
//               animation: _fishController,
//               builder: (context, child) {
//                 return Positioned(
//                   bottom: 120 + 15 * math.cos(_fishSwimAnimation.value * math.pi),
//                   left: 40,
//                   child: Opacity(
//                     opacity: 0.6,
//                     child: Text(
//                       '🦐',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Custom painter for animated waves
// class WavePainter extends CustomPainter {
//   final double animationValue;
//
//   WavePainter(this.animationValue);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..shader = LinearGradient(
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//         colors: [
//           const Color(0xFF001F3F).withOpacity(0.8), // Deep Navy
//           const Color(0xFF003366).withOpacity(0.85), // Dark Ocean Blue
//           const Color(0xFF004C6D).withOpacity(0.9),
//         ],
//       ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
//
//     final path = Path();
//     path.moveTo(0, size.height * 0.3);
//
//     for (double x = 0; x <= size.width; x++) {
//       final y = size.height * 0.3 +
//           20 * math.sin((x / size.width * 4 * math.pi) + animationValue) +
//           10 * math.sin((x / size.width * 8 * math.pi) + animationValue * 2);
//       path.lineTo(x, y);
//     }
//
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
//
// // Custom painter for fish shape
// class FishPainter extends CustomPainter {
//   final Color color;
//
//   FishPainter(this.color);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;
//
//     final path = Path();
//
//     // Fish body (oval)
//     final fishBody = Rect.fromCenter(
//       center: Offset(size.width * 0.4, size.height * 0.5),
//       width: size.width * 0.6,
//       height: size.height * 0.8,
//     );
//     path.addOval(fishBody);
//
//     // Fish tail
//     path.moveTo(size.width * 0.1, size.height * 0.5);
//     path.lineTo(0, size.height * 0.2);
//     path.lineTo(0, size.height * 0.8);
//     path.close();
//
//     canvas.drawPath(path, paint);
//
//     // Fish eye
//     final eyePaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(
//       Offset(size.width * 0.6, size.height * 0.4),
//       size.width * 0.08,
//       eyePaint,
//     );
//
//     final pupilPaint = Paint()
//       ..color = Colors.black
//       ..style = PaintingStyle.fill;
//
//     canvas.drawCircle(
//       Offset(size.width * 0.6, size.height * 0.4),
//       size.width * 0.04,
//       pupilPaint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

