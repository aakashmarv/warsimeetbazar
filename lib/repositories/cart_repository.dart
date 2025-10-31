

import '../constants/api_constants.dart';
import '../models/responses/cart_response.dart';
import '../services/api_service.dart';

class CartItemRepo {
  final _dio = ApiService.dio;

  Future<CartResponse> fetchcartItems() async {
    final response = await _dio.get(ApiConstants.cartUrl);

    return CartResponse.fromJson(response.data);
  }
}