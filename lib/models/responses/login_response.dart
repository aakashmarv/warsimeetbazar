class LoginResponse {
  final bool? status;
  final String? message;
  final String? accessToken;
  final String? tokenType;
  final UserData? user;
  final int? expiresIn;

  LoginResponse({
    this.status,
    this.message,
    this.accessToken,
    this.tokenType,
    this.user,
    this.expiresIn,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json["status"] as bool?,
      message: json["message"] as String?,
      accessToken: json["access_token"] as String?,
      tokenType: json["token_type"] as String?,
      user: json["user"] != null ? UserData.fromJson(json["user"]) : null,
      expiresIn: json["expires_in"] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "message": message,
      "access_token": accessToken,
      "token_type": tokenType,
      "user": user?.toJson(),
      "expires_in": expiresIn,
    };
  }
}

class UserData {
  final int? id;
  final String? name;
  final String? email;
  final String? avatar;
  final String? phone;
  final String? address;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? role;
  final String? status;
  final String? emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;

  UserData({
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.phone,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.role,
    this.status,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json["id"] as int?,
      name: json["name"] as String?,
      email: json["email"] as String?,
      avatar: json["avatar"] as String?,
      phone: json["phone"] as String?,
      address: json["address"] as String?,
      city: json["city"] as String?,
      state: json["state"] as String?,
      country: json["country"] as String?,
      zipcode: json["zipcode"] as String?,
      role: json["role"] as String?,
      status: json["status"] as String?,
      emailVerifiedAt: json["email_verified_at"] as String?,
      createdAt: json["created_at"] as String?,
      updatedAt: json["updated_at"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "avatar": avatar,
      "phone": phone,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "zipcode": zipcode,
      "role": role,
      "status": status,
      "email_verified_at": emailVerifiedAt,
      "created_at": createdAt,
      "updated_at": updatedAt,
    };
  }
}
