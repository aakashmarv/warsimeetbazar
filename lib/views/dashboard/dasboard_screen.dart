import 'package:dry_fish/views/account/account_screen.dart';
import 'package:dry_fish/views/cart/cart_screen.dart';
import 'package:dry_fish/views/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../Constants/app_colors.dart';
import '../../viewmodels/cart_item_controller.dart';
import '../../viewmodels/dashboard_controller.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = Get.put(DashboardController());
  final CartItemController cartController = Get.put(CartItemController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String currentAddress = "Fetching your location...";
  Position? currentPosition;

  final List<Widget> _screens = [
    const HomeScreen(),
    SearchScreen(),
    const CartScreen(showAppBar: false),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _showLocationBottomSheet();
      await _getCurrentLocation();
      cartController.fetchItems();
    });
  }

  /// 🔹 Get current location & convert to address
  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() {
          currentAddress = "Location permission denied";
        });
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      setState(() {
        currentPosition = position;
      });

      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        setState(() {
          currentAddress =
              "${place.street}, ${place.thoroughfare}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode},";
        });
        print(" your current address is == ${currentAddress}|| ${position.latitude} || ${position.longitude}");
      }
    } catch (e) {
      setState(() {
        currentAddress = "Error getting location: $e";
      });
    }
  }

  /// 🔹 Request app permissions
  Future<void> _requestPermissions() async {
    var locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Location permission is required")),
      );
    }

    var notificationStatus = await Permission.notification.request();
    if (notificationStatus.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notification permission is required")),
      );
    }
  }

  /// 🔹 Show location bottom sheet
  void _showLocationBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
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
    final statusBarHeight = mediaQuery.padding.top;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Obx(
          () => Column(
            children: [
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
                                  "Your Location",
                                  style: GoogleFonts.nunito(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              currentAddress,
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
              Expanded(child: _screens[controller.selectedIndex.value]),
            ],
          ),
        ),
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
            items: [
              const BottomNavigationBarItem(
                icon: Icon(LucideIcons.house),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(LucideIcons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Obx(() {
                  final itemCount = cartController.totalItems.value;
                  final hasItems = itemCount > 0;
                  print("🧾 Badge Update → totalItems: $itemCount | hasItems: $hasItems");

                  return Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(LucideIcons.shoppingBag),
                      if (hasItems)
                        Positioned(
                          right: -6,
                          top: -4,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              itemCount.toString(),
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
              const BottomNavigationBarItem(
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
