class AddNewAddressResponse {
  final bool status;
  final String message;

  AddNewAddressResponse({required this.status, required this.message});

  factory AddNewAddressResponse.fromJson(Map<String, dynamic> json) {
    return AddNewAddressResponse(
      status: json["status"] ?? false,
      message: json["message"] ?? "",
    );
  }
}
