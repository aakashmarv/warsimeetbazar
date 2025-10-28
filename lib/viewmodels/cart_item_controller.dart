import 'package:get/get.dart';
import '../../models/responses/cart_response.dart';
import '../../repositories/cart_repository.dart';

class CartItemController extends GetxController {
  final _repo = CartItemRepo();

  /// Observables
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final cartItems = <CartItem>[].obs;

  /// Totals
  RxInt totalItems = 0.obs;
  RxDouble totalPrice = 0.0.obs;

  /// Fetch cart items from API
  Future<void> fetchItems() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _repo.fetchcartItems();

      if (response.success && response.cart != null) {
        cartItems.assignAll(response.cart!);
        updateTotals();
      } else {
        errorMessage.value = 'Failed to load cart items';
      }
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
    }
  }

  /// Calculate total items and total price
  void updateTotals() {
    totalItems.value = cartItems.fold(
      0,
      (sum, item) => sum + (item.quantity ?? 0),
    );

    totalPrice.value = cartItems.fold(
      0.0,
      (sum, item) => sum + ((item.total ?? 0.0)),
    );
  }
}
