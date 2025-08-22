class LoginRequest {
  final String identifier;
  final String password;

  LoginRequest({required this.identifier, required this.password});

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "password": password,
  };
}

class LoginResponse {
  final String message;
  final int statusCode;
  final FilteredUser user;
  final Token token;

  LoginResponse({
    required this.message,
    required this.statusCode,
    required this.user,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'];
    return LoginResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      user: FilteredUser.fromJson(payload['filteredUser']),
      token: Token.fromJson(payload['token']),
    );
  }
}

class FilteredUser {
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

  FilteredUser({
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

  factory FilteredUser.fromJson(Map<String, dynamic> json) => FilteredUser(
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

class Token {
  final String accessToken;

  Token({required this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) =>
      Token(accessToken: json['access_token']);
}



// class UserModel {
//   final int id;
//   final String name;
//   final String email;
//   final String phone;
//   final String role;
//
//   UserModel({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.role,
//   });
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//     id: json['id'],
//     name: json['name'],
//     email: json['email'],
//     phone: json['phone'],
//     role: json['role'],
//   );
// }
//
// class TokenModel {
//   final String accessToken;
//
//   TokenModel({required this.accessToken});
//
//   factory TokenModel.fromJson(Map<String, dynamic> json) =>
//       TokenModel(accessToken: json['access_token']);
// }
//
// class LoginResponseModel {
//   final String message;
//   final int statusCode;
//   final UserModel user;
//   final TokenModel token;
//
//   LoginResponseModel({
//     required this.message,
//     required this.statusCode,
//     required this.user,
//     required this.token,
//   });
//
//   factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
//     final payload = json['payload'] ?? {};
//     return LoginResponseModel(
//       message: json['message'] ?? '',
//       statusCode: json['statusCode'] ?? 0,
//       user: payload['user'] != null ? UserModel.fromJson(payload['user']) : throw Exception('User missing'),
//       token: payload['token'] != null ? TokenModel.fromJson(payload['token']) : throw Exception('Token missing'),
//     );
//   }
//
// }
