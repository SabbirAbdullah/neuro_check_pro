class UserInfoResponse {
  final String message;
  final int statusCode;
  final UserInfoModel payload;

  UserInfoResponse({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) {
    return UserInfoResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      payload: UserInfoModel.fromJson(json['payload']),
    );
  }
}

class UserInfoModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final int age;
  final String country;
  final String state;
  final String postCode;
  final String street;
  final String role;
  final String knowHow;

  UserInfoModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.country,
    required this.state,
    required this.postCode,
    required this.street,
    required this.role,
    required this.knowHow,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    age: json['age'],
    country: json['country'],
    state: json['state'],
    postCode: json['postCode'],
    street: json['street'],
    role: json['role'],
    knowHow: json['knowHow'],
  );
}
