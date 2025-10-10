import 'package:dry_fish/models/responses/products_response.dart';
import '../constants/api_constants.dart';
import '../services/api_service.dart';

class ProductsRepository {
  final _dio = ApiService.dio;

  Future<ProductsResponse> product(int categoryId) async {
    final response = await _dio.get(
      ApiConstants.productByCategoryUrl(categoryId),
    );
    return ProductsResponse.fromJson(response.data);
  }
}
