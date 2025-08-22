class SignupRequest {
  final String name;
  final String email;
  final String password;
  final String phone;
  final int age;
  final String country;
  final String state;
  final String postCode;
  final String street;
  final String role;
  final String knowHow;
  final String otp;
  final String identifier;

  SignupRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.age,
    required this.country,
    required this.state,
    required this.postCode,
    required this.street,
    required this.role,
    required this.knowHow,
    required this.otp,
    required this.identifier,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
    "age": age,
    "country": country,
    "state": state,
    "postCode": postCode,
    "street": street,
    "role": role,
    "knowHow": knowHow,
    "otp": otp,
    "identifier": identifier,
  };
}

class SignupResponse {
  final String message;
  final int statusCode;
  final User user;
  final Token token;

  SignupResponse({
    required this.message,
    required this.statusCode,
    required this.user,
    required this.token,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['payload'];
    return SignupResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      user: User.fromJson(payload['user']),
      token: Token.fromJson(payload['token']),
    );
  }
}

class User {
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

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
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
