import 'package:get/get.dart';
import '../../models/static responses/saved_address_response.dart';

class SavedAddressController extends GetxController {
  final isLoading = false.obs;
  final addresses = <AddressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  /// Dummy Data (Replace later with API)
  Future<void> fetchAddresses() async {
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 600));

    addresses.value = [
      AddressModel(
        name: "Rahul Sharma",
        address: "Flat No. 204, Ganga Residency, Sector 12, Indira Nagar, Lucknow, 226016",
        phone: "9876543210",
        typeIcon: "home",
      ),
      AddressModel(
        name: "Priya Verma",
        address: "Near Metro Station, Rajajipuram, Alambagh, Lucknow, 226005",
        phone: "9123456780",
        typeIcon: "city",
      ),
      AddressModel(
        name: "Rohit Singh",
        address: "House No. 22, Shyam Vihar Colony, Gomti Nagar, Lucknow, 226010",
        phone: "9988776655",
        typeIcon: "home",
      ),
      AddressModel(
        name: "Aman Gupta",
        address: "Behind SBI Bank, Aashiyana Phase 1, Kanpur Road, Lucknow, 226012",
        phone: "9911223344",
        typeIcon: "location",
      ),
    ];

    isLoading.value = false;
  }
}
