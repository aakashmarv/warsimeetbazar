import 'package:get/get.dart';
import '../../models/requests/add_to_cart_request.dart';
import '../../models/responses/add_to_cart_response.dart';
import '../../repositories/addtocart_repository.dart';

class AddToCartController extends GetxController {
  final AddtocartRepository repository;

  AddToCartController({required this.repository});

  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final response = Rxn<AddToCartResponse>();

  Future<void> addToCart(AddToCartRequest request) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await repository.addtocart(request);
      response.value = result;

      if (result.status) {
        Get.snackbar('Success', result.message);
      } else {
        Get.snackbar('Failed', result.message);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
