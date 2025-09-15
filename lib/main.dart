// import 'package:device_preview/device_preview.dart';
import 'package:dry_fish/roots/routes.dart';
import 'package:dry_fish/services/sharedpreferences_service.dart';
import 'package:dry_fish/utils/thems/app_theme.dart';
import 'package:dry_fish/viewmodels/app_state_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/app_strings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferencesService.getInstance();
  final appStateController = AppStateController(prefs);
  await appStateController.initialize();
  Get.put(appStateController);
  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode, // disable in release builds
  //     builder: (context) => const MyApp(), // wrap your main app
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Get.find<AppStateController>();
    return Obx(()=>GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      themeMode: appState.themeMode.value,

      // useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,

      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.getRoutes(),
    ));
  }
}
