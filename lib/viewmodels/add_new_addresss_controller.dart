import 'package:get/get.dart';
import '../models/requests/add_new_address_request.dart';
import '../models/responses/add_new_address_response.dart';
import '../repositories/add_new_address_repository.dart';
import '../utils/snackbar_util.dart';

class AddNewAddressController extends GetxController {
  final AddNewAddressRepository _repository = AddNewAddressRepository();

  var isLoading = false.obs;
  AddNewAddressResponse? addNewAddressResponse;

  Future<void> addNewAddress(AddNewAddressRequest request) async {
    try {
      isLoading.value = true;

      final response = await _repository.addnewaddress(request);
      addNewAddressResponse = response;

      if (response.status == true) {
        SnackbarUtil.showSuccess("Success", response.message);
      } else {
        SnackbarUtil.showError("Failed", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
