import '../constants/api_constants.dart';
import '../models/responses/saved_addresses_response.dart';
import '../services/api_service.dart';

class AddressListRespository {
  final _dio = ApiService.dio;

  Future<SavedAddressResponse> getaddresslist() async {
    final response = await _dio.get(
      ApiConstants.savedAddressesUrl,
    );
    return SavedAddressResponse.fromJson(response.data);
  }
}