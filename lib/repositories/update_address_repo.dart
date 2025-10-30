import '../constants/api_constants.dart';
import '../models/requests/update_address_request.dart';
import '../models/responses/update_address_response.dart';
import '../services/api_service.dart';

class UpdateAddressRepo {
  final _dio = ApiService.dio;

  Future<UpdateAddressResponse> updateAddress({
    required String id,
    required UpdateAddressRequest request,
  }) async {
    final url = "${ApiConstants.updateaddressUrl}/$id"; 
    final response = await _dio.post(
      url,
      data: request.toJson(),
    );

    return UpdateAddressResponse.fromJson(response.data);
  }
}
