import 'package:get/get.dart';
import '../../models/responses/cart_response.dart';
import '../../repositories/cart_repository.dart';

class CartItemController extends GetxController {
  final _repo = CartItemRepo();
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final cartItems = <CartItem>[].obs;
  RxInt totalItems = 0.obs;
  RxDouble totalPrice = 0.0.obs;

  final Map<int, RxBool> itemLoading = {};

  void initItemLoaders() {
    for (var item in cartItems) {
      itemLoading[item.id] ??= false.obs;
    }
  }

  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      print("🛒 Fetching cart items from API...");

      final response = await _repo.fetchcartItems();

      print("📦 Raw Cart API Response: ${response.toString()}");

      if (response.success == true &&
          response.cart.isNotEmpty) {
        cartItems.assignAll(response.cart);
        print("✅ Cart items loaded → ${cartItems.length}");
      } else {
        cartItems.clear();
        print("⚠️ API says cart is empty");
      }

      updateTotals();
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      print("❌ Error fetching cart: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void updateTotals() {
    totalItems.value = cartItems.fold(
      0,
      (sum, item) => sum + (item.quantity),
    );

    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.total),
    );

    print(
      "🧾 Badge Update → totalItems: ${totalItems.value} | hasItems: ${totalItems.value > 0}",
    );
  }
}
