class RemoveCartItemResponse {
  final bool status;
  final String message;

  RemoveCartItemResponse({
    required this.status,
    required this.message,
  });

  factory RemoveCartItemResponse.fromJson(Map<String, dynamic> json) {
    return RemoveCartItemResponse(
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
