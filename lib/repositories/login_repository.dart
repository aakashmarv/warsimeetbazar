import '../constants/api_constants.dart';
import '../models/requests/login_request.dart';
import '../models/responses/login_response.dart';
import '../services/api_service.dart';

class LoginRepository {
  final _dio = ApiService.dio;

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _dio.post(
      ApiConstants.loginUrl,
      data: request.toJson(),
    );
    return LoginResponse.fromJson(response.data);
  }
}
