class DeleteAddressResponse {
  final bool status;
  final String message;

  DeleteAddressResponse({
    required this.status,
    required this.message,
  });

  factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAddressResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
