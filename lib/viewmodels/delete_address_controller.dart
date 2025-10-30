import 'package:get/get.dart';
import '../repositories/delete_address_repository.dart';
import '../utils/snackbar_util.dart';

class DeleteAddressController extends GetxController {
  final DeleteAddressRepository _repository = DeleteAddressRepository();

  var deletingId = "".obs;

  Future<bool> deleteAddress(String id) async {
    try {
      deletingId.value = id;
      final response = await _repository.removeaddress(Id: id);
      if (response.status) {
        SnackbarUtil.showSuccess("Success", response.message);
        return true;
      } else {
       SnackbarUtil.showError("Failed", response.message);
        return false;
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      deletingId.value = "";
    }
  }
}
