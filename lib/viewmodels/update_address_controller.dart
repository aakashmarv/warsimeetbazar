import 'package:get/get.dart';
import '../models/requests/update_address_request.dart';
import '../models/responses/update_address_response.dart';
import '../repositories/update_address_repo.dart';

class AddressController extends GetxController {
  final Updateaddressrepo _repository;

  AddressController(this._repository);

  var isLoading = false.obs;
  var updateResponse = Rxn<UpdateAddressResponse>();
  var errorMessage = ''.obs;

  /// Call this to update the user's address
  Future<void> updateAddress({
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipcode,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      final request = UpdateAddressRequest(
        address: address,
        city: city,
        state: state,
        country: country,
        zipcode: zipcode,
      );

      final response = await _repository.updateAddress(request);
      updateResponse.value = response;

      if (!response.status) {
        errorMessage.value = "Failed to update address";
      }

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
