class ReduceQuantityResponse {
  final bool status;
  final String message;

  ReduceQuantityResponse({
    required this.status,
    required this.message,
  });

  factory ReduceQuantityResponse.fromJson(Map<String, dynamic> json) {
    return ReduceQuantityResponse(
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
