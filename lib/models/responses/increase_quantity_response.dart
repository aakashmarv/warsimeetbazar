class IncreaseQuantityResponse {
  final bool status;
  final String message;

  IncreaseQuantityResponse({
    required this.status,
    required this.message,
  });

  factory IncreaseQuantityResponse.fromJson(Map<String, dynamic> json) {
    return IncreaseQuantityResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
