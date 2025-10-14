import 'package:get/get.dart';

class CartController extends GetxController {
  var totalItems = 0.obs;
  var totalPrice = 0.0.obs;

  void addItem(int qty, double price) {
    totalItems.value += qty;
    totalPrice.value += qty * price;
  }

  void removeItem(int qty, double price) {
    if (totalItems.value > 0) {
      totalItems.value -= qty;
      totalPrice.value -= qty * price;
    }
  }

  void clearCart() {
    totalItems.value = 0;
    totalPrice.value = 0.0;
  }
}
