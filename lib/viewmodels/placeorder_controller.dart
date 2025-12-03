import 'package:dry_fish/roots/routes.dart';
import 'package:get/get.dart';
import '../models/requests/place_order_request.dart';
import '../models/responses/placeorder_response.dart';
import '../repositories/placeorder_repository.dart';
import '../utils/snackbar_util.dart';

class PlaceOrderController extends GetxController {
  final PlaceorderRepository _repository = PlaceorderRepository();
  final isLoading = false.obs;
  final order = Rxn<Order>();

  Future<void> placeOrderCont(PlaceOrderRequest request) async {
    isLoading.value = true;
    try {
      print("📦 Sending Order Request: ${request.toJson()}");

      final response = await _repository.placeOrder(request);

      print("📥 Response Received: ${response}");

      if (response.status == "success" ||
          response.status == true ||
          response.status == "true") {
        order.value = response.order;

        print("✅ Order Success — ID: ${response.order?.id}");
        Get.offAllNamed(AppRoutes.orderConfirmer, arguments: response.order);
      } else {
        print("❌ Order Failed: ${response.message}");

        SnackbarUtil.showError(
          "Order Failed",
          response.message ?? "Something went wrong while placing order.",
        );
      }

    } catch (e, stack) {
      print("🔥 ERROR while placing order:");
      print("Error: $e");
      print("StackTrace: $stack");

      SnackbarUtil.showError(
        "Error",
        "An unexpected error occurred: ${e.toString()}",
      );

    } finally {
      isLoading.value = false;
      print("⏳ Loading = false");
    }
  }
}
