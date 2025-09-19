import 'package:get/get.dart';

class DashboardController extends GetxController {
  /// Current selected index
  var currentIndex = 0.obs;

  /// Change screen
  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
