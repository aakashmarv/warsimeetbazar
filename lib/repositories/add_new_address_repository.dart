
import '../constants/api_constants.dart';
import '../models/requests/add_new_address_request.dart';
import '../models/responses/add_new_address_response.dart';
import '../services/api_service.dart';

class AddNewAddressRepository {
  final _dio = ApiService.dio;

  Future<AddNewAddressResponse> addnewaddress(AddNewAddressRequest request) async {
    final response = await _dio.post(
      ApiConstants.addnewaddressurl,
      data: request.toJson(),
    );
    return AddNewAddressResponse.fromJson(response.data);
  }
}
