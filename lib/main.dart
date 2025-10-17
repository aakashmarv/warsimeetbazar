// // import 'package:device_preview/device_preview.dart';
// import 'package:dry_fish/roots/routes.dart';
// import 'package:dry_fish/services/api_service.dart';
// import 'package:dry_fish/services/sharedpreferences_service.dart';
// import 'package:dry_fish/utils/thems/app_theme.dart';
// import 'package:dry_fish/viewmodels/app_state_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
// import 'constants/app_strings.dart';
// import 'viewmodels/internet_controller.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Get.put(InternetController()); 
//   final prefs = await SharedPreferencesService.getInstance();
//   final appStateController = AppStateController(prefs);
//   await appStateController.initialize();
//   Get.put(appStateController);
//   runApp(const MyApp());
//   // runApp(
//   //   DevicePreview(
//   //     enabled: !kReleaseMode, // disable in release builds
//   //     builder: (context) => const MyApp(), // wrap your main app
//   //   ),
//   // );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final appState = Get.find<AppStateController>();
//     return Sizer(
//       builder: (context, orientation, deviceType) {
//         return Obx(
//           () => GetMaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: AppStrings.appName,
//             theme: AppTheme.lightTheme,
//             darkTheme: AppTheme.lightTheme,
//             themeMode: appState.themeMode.value,
//             // useInheritedMediaQuery: true,
//             // locale: DevicePreview.locale(context),
//             // builder: DevicePreview.appBuilder,
//             initialRoute: AppRoutes.splash,
//             getPages: AppRoutes.getRoutes(),
//           ),
//         );
//       },
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'constants/app_strings.dart';
import 'roots/routes.dart';
import 'utils/thems/app_theme.dart';
import 'viewmodels/app_state_controller.dart';
import 'viewmodels/internet_controller.dart';
import 'services/sharedpreferences_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferencesService.getInstance();
  final appStateController = AppStateController(prefs);
  await appStateController.initialize();
  Get.put(appStateController);
  final internetController = Get.put(InternetController(), permanent: true);
  internetController.showPopup = false;
  runApp(const MyApp());

 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Get.find<AppStateController>();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Obx(
          () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.lightTheme,
            themeMode: appState.themeMode.value,
            initialRoute: AppRoutes.splash,
            getPages: AppRoutes.getRoutes(),
          ),
        );
      },
    );
  }
}
