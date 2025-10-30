class SavedAddressResponse {
  final bool status;
  final String message;
  final List<AddressModel> addresses;

  SavedAddressResponse({
    required this.status,
    required this.message,
    required this.addresses,
  });

  factory SavedAddressResponse.fromJson(Map<String, dynamic> json) {
    return SavedAddressResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => AddressModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class AddressModel {
  final int id;
  final int userId;
  final String name;
  final String phone;
  final String flat;
  final String street;
  final String building;
  final String country;
  final String city;
  final String state;
  final String zip;
  final String landmark;
  final String locality;
  final String addressType;
  final bool isSelected;

  AddressModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    required this.flat,
    required this.street,
    required this.building,
    required this.country,
    required this.city,
    required this.state,
    required this.zip,
    required this.landmark,
    required this.locality,
    required this.addressType,
    required this.isSelected,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      flat: json['flat'] ?? '',
      street: json['street'] ?? '',
      building: json['building'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      zip: json['zip'] ?? '',
      landmark: json['landmark'] ?? '',
      locality: json['locality'] ?? '',
      addressType: json['address_type'] ?? '',
      isSelected: json['is_selected'] == 1,
    );
  }
}
