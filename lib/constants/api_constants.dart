class ApiConstants {
  // Base URL
  static const String baseUrl = "https://uxbill.com/api/v1";
  static const String ImageBaseUrl = "https://uxbill.com/storage/";

  // Endpoints
  static const String loginUrl = "$baseUrl/user/login-or-signup-otp-send";

  static String updateCategoryUrl(String categoryId) => "$baseUrl/user/category/$categoryId";

}
