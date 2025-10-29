// import 'package:get/get.dart';
// import 'package:dry_fish/models/requests/place_order_request.dart';
// import 'package:dry_fish/models/responses/placeorder_response.dart';
// import '../repositories/placeorder_repository.dart';

// class PlaceOrderController extends GetxController {
//   final PlaceorderRepository repository;

//   PlaceOrderController({required this.repository});

//   // Observable variables
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var orderResponse = Rxn<PlaceorderResponse>();

//   // Method to place order
//   Future<void> placeOrder(PlaceOrderRequest request) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//       final response = await repository.placeOrder(request);
//       orderResponse.value = response;
//     } catch (e) {
//       errorMessage.value = e.toString();
//       orderResponse.value = null;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Optional: Clear response
//   void clear() {
//     orderResponse.value = null;
//     errorMessage.value = '';
//   }
// }



import 'package:get/get.dart';
import 'package:dry_fish/models/responses/placeorder_response.dart';
import '../repositories/placeorder_repository.dart';

class PlaceOrderController extends GetxController {
final PlaceorderRepository repository = PlaceorderRepository();
  // PlaceOrderController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var orderResponse = Rxn<PlaceorderResponse>();

  /// Call API (no request body)
  Future<void> placeOrder() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await repository.placeOrder();
      orderResponse.value = response;
    } catch (e) {
      errorMessage.value = e.toString();
      orderResponse.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  void clear() {
    orderResponse.value = null;
    errorMessage.value = '';
  }
}
