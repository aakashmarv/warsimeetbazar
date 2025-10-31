class AddNewAddressRequest {
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

  AddNewAddressRequest({
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

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "flat": flat,
      "street": street,
      "building": building,
      "country": country,
      "city": city,
      "state": state,
      "zip": zip,
      "landmark": landmark,
      "locality": locality,
      "address_type": addressType,
      "is_selected": isSelected,
    };
  }
}
