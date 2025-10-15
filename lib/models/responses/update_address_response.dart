class UpdateAddressResponse {
  final bool status;
  final String message;

  UpdateAddressResponse({
    required this.status,
    required this.message,
  });

  factory UpdateAddressResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAddressResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
