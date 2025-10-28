// import 'package:dry_fish/models/requests/place_order_request.dart';
// import 'package:dry_fish/models/responses/placeorder_response.dart';
// import '../constants/api_constants.dart';
// import '../services/api_service.dart';

// class PlaceorderRepository {
//   final _dio = ApiService.dio;

//   Future<PlaceorderResponse> placeOrder(PlaceOrderRequest request) async {
//     final response = await _dio.post(
//       ApiConstants.placeorderurl,
//       data: request.toJson(),
//     );
//     return PlaceorderResponse.fromJson(response.data);
//   }
// }



import 'package:dry_fish/models/responses/placeorder_response.dart';
import '../constants/api_constants.dart';
import '../services/api_service.dart';

class PlaceorderRepository {
  final _dio = ApiService.dio;

  /// API call to place order without sending any bodyR
  Future<PlaceorderResponse> placeOrder() async {
    final response = await _dio.post(ApiConstants.placeorderurl);
    return PlaceorderResponse.fromJson(response.data);
  }
}
