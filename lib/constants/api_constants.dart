class ApiConstants {
  // Base URL
  static const String baseUrl = "https://chavanbrothers.co.in/api";
  static const String imageBaseUrl = "https://chavanbrothers.co.in/";

  // Endpoints
  static const String loginUrl = "$baseUrl/user/login";
  static const String getCategoryUrl = "$baseUrl/user/categories";

  static String productByCategoryUrl(int categoryId) => "$baseUrl/products/categories/$categoryId";

}
