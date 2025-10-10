class LoginRequest {
  final String phone;
  final String password;

  // Constructor
  LoginRequest({
    required this.phone,
    required this.password,
  });

  // Method to convert the Dart object into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
    };
  }
}