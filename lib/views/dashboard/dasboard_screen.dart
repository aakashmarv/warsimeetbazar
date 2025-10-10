import 'package:dry_fish/views/account/account_screen.dart';
import 'package:dry_fish/views/cart/cart_screen.dart';
import 'package:dry_fish/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../Constants/app_colors.dart';
import '../../viewmodels/cart_controller.dart';
import '../../viewmodels/dashboard_controller.dart';
import 'home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.put(DashboardController());
  final CartController cartController = Get.put(CartController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _screens = [
    const HomeScreen(),
    SearchScreen(),
    const CartScreen(showAppBar: false),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLocationBottomSheet();
    });
  }

  Future<void> _requestPermissions() async {
    // Location Permission
    var locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission is required")),
      );
    }

    // Notification Permission (Android 13+ / iOS)
    var notificationStatus = await Permission.notification.request();
    if (notificationStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notification permission is required")),
      );
    }
  }

  void _showLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // bahar tap se close na ho
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop(); // back press -> app exit
            return false;
          },
          child: SafeArea(
            minimum: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Set Your Location",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _requestPermissions();
                    },
                    child: const Text("Use Current Location"),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: AppColors.black,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      _requestPermissions();
                    },
                    child: const Text("Set on Map"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  final Rxn<DateTime> _lastBackPressed = Rxn<DateTime>();

  Future<bool> _onWillPop() async {
    if (_scaffoldKey.currentState?.isDrawerOpen == true) {
      Navigator.of(context).pop();
      return false;
    }

    if (controller.selectedIndex.value != 0) {
      controller.changeTab(0);
      return false;
    }

    DateTime now = DateTime.now();
    if (_lastBackPressed.value == null ||
        now.difference(_lastBackPressed.value!) > const Duration(seconds: 3)) {
      _lastBackPressed.value = now;
      Fluttertoast.showToast(msg: "Press back again to exit");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final statusBarHeight = mediaQuery.padding.top; // status bar ka height

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Obx(
              () => Column(
            children: [
              /// Show AppBar only for index 0
              if (controller.selectedIndex.value == 0)
                Container(
                  width: screenWidth,
                  padding: EdgeInsets.only(
                    top: statusBarHeight + 8,
                    left: screenWidth * 0.04,
                    right: screenWidth * 0.04,
                    bottom: screenHeight * 0.012,
                  ),
                  color: AppColors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: AppColors.alertRed),
                                SizedBox(width: screenWidth * 0.01),
                                Text(
                                  "Sector C",
                                  style: GoogleFonts.nunito(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "569/153-GA, Kanpur Rd, adjacent...",
                              style: GoogleFonts.nunito(
                                fontSize: screenWidth * 0.030,
                                color: AppColors.darkGrey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        "assets/images/logo_cb_black.png",
                        height: screenWidth * 0.10,
                        width: screenWidth * 0.18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
      
              /// Selected Screen
              Expanded(child: _screens[controller.selectedIndex.value]),
            ],
          ),
        ),
      
        /// Bottom Navigation Bar
        bottomNavigationBar: Obx(
              () => BottomNavigationBar(
            backgroundColor: AppColors.white,
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.darkGrey,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 14,
            unselectedFontSize: 12,
            iconSize: 24,
            onTap: controller.selectedIndex,
            items:  [
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.house),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Obx(() {
                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(LucideIcons.shoppingBag),
                      if (cartController.totalItems.value > 0)
                        Positioned(
                          right: -6,
                          top: -4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              "${cartController.totalItems.value}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                }),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(LucideIcons.user),
                label: "Account",
              ),
            ],
          ),
        ),
      ),
    );
  }
}