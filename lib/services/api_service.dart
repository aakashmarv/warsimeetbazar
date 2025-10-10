import 'package:dio/dio.dart';
import 'package:dry_fish/services/sharedpreferences_service.dart';
import '../constants/api_constants.dart';
import '../constants/app_keys.dart';
import '../utils/logger.dart';

// class ApiService {
//   static final Dio dio = Dio(
//     BaseOptions(
//       baseUrl: ApiConstants.baseUrl,
//       connectTimeout: const Duration(seconds: 15),
//       receiveTimeout: const Duration(seconds: 15),
//       headers: {
//         "Accept": "application/json",
//         "Content-Type": "application/json",
//       },
//     ),
//   )..interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) async {
//         // Load token from SharedPreferences
//         final prefs = await SharedPreferencesService.getInstance();
//         final token = prefs.getString(AppKeys.token);
//
//         // Log Request
//         print("📤 REQUEST → ${options.method} ${options.uri}");
//         print("🔸 Headers: ${options.headers}");
//         print("🔸 Data: ${options.data}");
//
//         // Add Bearer token if available
//         if (token != null && token.isNotEmpty) {
//           options.headers['Authorization'] = 'Bearer $token';
//           print("🔐 Bearer Token attached");
//         }
//
//         return handler.next(options);
//       },
//
//       onResponse: (response, handler) {
//         print("✅ RESPONSE ← ${response.statusCode} ${response.requestOptions.uri}");
//         print("📦 Response Data: ${response.data}");
//         return handler.next(response);
//       },
//
//       onError: (DioError e, handler) {
//         print("❌ ERROR ← ${e.response?.statusCode} ${e.requestOptions.uri}");
//         print("🧯 Message: ${e.message}");
//         print("📦 Error Data: ${e.response?.data}");
//         return handler.next(e);
//       },
//     ),
//   );
//
//   // static TripListScreen createDio() {}
// }

class ApiService {
  static final Dio dio = Dio();
  static String? _cachedToken;

  static Future<void> init() async {
    final prefs = await SharedPreferencesService.getInstance();
    _cachedToken = prefs.getString(AppKeys.token);
    dio.options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (_cachedToken != null && _cachedToken!.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $_cachedToken';
            appLog("🔐 Bearer Token attached");
          }
          _logRequest(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          _logResponse(response);
          return handler.next(response);
        },
        onError: (e, handler) {
          _logError(e);
          return handler.next(e);
        },
      ),
    );
  }

  static void _logRequest(RequestOptions options) {
    appLog("📤 REQUEST → ${options.method} ${options.uri}");
    appLog("🔸 Headers: ${options.headers}");
    appLog("🔸 Data: ${options.data}");
    if (options.data != null) print("🔸 Body: ${options.data}");
  }

  static void _logResponse(Response response) {
    appLog("✅ RESPONSE ← ${response.statusCode} ${response.requestOptions.uri}");
    appLog("📦 Response Data: ${response.data}");
  }

  static void _logError(DioException e) {
    appLog("❌ ERROR ← ${e.response?.statusCode} ${e.requestOptions.uri}");
    appLog("🧯 Message: ${e.message}");
    appLog("📦 Error Data: ${e.response?.data}");
  }
}

