import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../constants/app_colors.dart';

class InternetController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;
  bool showPopup = true; // 👈 new flag

  @override
  void onInit() {
    super.onInit();
    _monitorInternetConnection();
  }

  void _monitorInternetConnection() async {
    await _checkConnection();

    _connectivity.onConnectivityChanged.listen((result) async {
      await _checkConnection();
    });
  }
Future<void> waitForConnection() async {
  while (!isConnected.value) {
    await Future.delayed(const Duration(seconds: 1));
  }
}

  Future<void> _checkConnection() async {
    final result = await _connectivity.checkConnectivity();

    if (result == ConnectivityResult.none || !(await _hasInternetAccess())) {
      if (isConnected.value) {
        isConnected.value = false;
                if (showPopup) _showNoInternetDialog(); // 👈 popup only if allowed

      }
    } else {
      if (!isConnected.value) {
        isConnected.value = true;
        if (Get.isDialogOpen ?? false) {
          Get.back(closeOverlays: true);
        }
      }
    }
  }

  /// Try to reach google.com to verify internet access
  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _showNoInternetDialog() {
    if (Get.isDialogOpen != true) {
      Future.delayed(const Duration(milliseconds: 200), () {
        if (Get.isDialogOpen != true) {
          Get.dialog(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.all(16.sp),
              title: Column(
                children: [
                  Icon(Icons.wifi_off, color: AppColors.primary, size: 30.sp),
                  SizedBox(height: 12.sp),
                  Text(
                    'No Internet Connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Please check your network and try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 14.sp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        icon: const Icon(Icons.wifi, color: Colors.blue),
                        label: const Text(
                          'Wi-Fi',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          AppSettings.openAppSettings(
                            type: AppSettingsType.wifi,
                          );
                        },
                      ),
                      TextButton.icon(
                        icon: const Icon(
                          Icons.network_cell,
                          color: Colors.orange,
                        ),
                        label: const Text(
                          'Internet',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          AppSettings.openAppSettings(
                            type: AppSettingsType.dataRoaming,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            barrierDismissible: false,
          );
        }
      });
    }
  }
}