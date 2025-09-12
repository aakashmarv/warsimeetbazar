import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Constants/app_colors.dart';
import 'home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    Center(child: Text("Categories")),
    Center(child: Text("Search")),
    Center(child: Text("Account")),
  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final statusBarHeight = mediaQuery.padding.top; // status bar ka height

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Column(
        children: [
          // Custom AppBar
          Container(
            width: screenWidth,
            padding: EdgeInsets.only(
              top: statusBarHeight + 8, // status bar ke neeche se start hoga
              left: screenWidth * 0.04,
              right: screenWidth * 0.04,
              bottom: screenHeight * 0.012,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        const Icon(Icons.location_on, color: AppColors.alertRed),
                        SizedBox(width: screenWidth * 0.01),
                        Text(
                          "Sector C",
                          style: GoogleFonts.nunito(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black,
                          ),
                        ),
                      ],),
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
                      "assets/images/logocb.png",
                      height: screenWidth * 0.10,
                      width: screenWidth * 0.10,
                      fit: BoxFit.cover,
                    ),

                // Expanded(
                //   flex: 2,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Icon(Icons.access_time, color: AppColors.primary, size: screenWidth * 0.05),
                //       SizedBox(width: screenWidth * 0.01),
                //       Flexible(
                //         child: Text(
                //           "Delivering Tomorrow",
                //           style: GoogleFonts.nunito(
                //             fontSize: screenWidth * 0.032,
                //             fontWeight: FontWeight.w600,
                //             color: AppColors.black,
                //           ),
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          // Selected Screen
          Expanded(child: _screens[_currentIndex]),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.white,
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded), label: "Orders"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}
