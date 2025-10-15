class UpdateAddressRequest {
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipcode;

  UpdateAddressRequest({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipcode,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
    };
  }
}
