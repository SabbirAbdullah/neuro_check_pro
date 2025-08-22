class SendOtpRequest {
  final String identifier;

  SendOtpRequest({required this.identifier});

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
  };
}

class SendOtpResponse {
  final String message;
  final int statusCode;

  SendOtpResponse({required this.message, required this.statusCode});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      message: json['message'],
      statusCode: json['statusCode'],
    );
  }
}

class VerifyOtpRequest {
  final String identifier;
  final String otp;

  VerifyOtpRequest({required this.identifier, required this.otp});

  Map<String, dynamic> toJson() => {
    "identifier": identifier,
    "otp": otp,
  };
}

class VerifyOtpResponse {
  final String message;
  final int statusCode;
  final bool verified;

  VerifyOtpResponse({
    required this.message,
    required this.statusCode,
    required this.verified,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      verified: json['payload']?['verified'] ?? false,
    );
  }
}
