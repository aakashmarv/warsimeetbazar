import '../constants/api_constants.dart';
import '../models/requests/update_address_request.dart';
import '../models/responses/update_address_response.dart';
import '../services/api_service.dart';

class Updateaddressrepo {
  final _dio = ApiService.dio;

  Future<UpdateAddressResponse> updateAddress(UpdateAddressRequest request) async {
    final response = await _dio.post(
      ApiConstants.updateaddressUrl(),
      data: request.toJson(),
    );
    return UpdateAddressResponse.fromJson(response.data);
  }
}
