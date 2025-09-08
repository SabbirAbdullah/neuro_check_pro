class PatientRequestModel {
  final String name;
  final String dateOfBirth;
  final String gender;
  final String relationshipToUser;
  final String aboutGp;
  final String profileTag;
  final int userId;

  PatientRequestModel({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.relationshipToUser,
    required this.aboutGp,
    required this.profileTag,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "dateOfBirth": dateOfBirth,
    "gender": gender,
    "relationshipToUser": relationshipToUser,
    "aboutGp": aboutGp,
    "profileTag": profileTag,
    "userId": userId,
  };
}

class PatientResponseModel {
  final String message;
  final int statusCode;
  final PatientPayload payload;

  PatientResponseModel({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory PatientResponseModel.fromJson(Map<String, dynamic> json) {
    return PatientResponseModel(
      message: json["message"],
      statusCode: json["statusCode"],
      payload: PatientPayload.fromJson(json["payload"]),
    );
  }
}

class PatientPayload {
  final String name;
  final String dateOfBirth;
  final String gender;
  final String relationshipToUser;
  final String aboutGp;
  final String profileTag;
  final int userId;
  final int id;

  PatientPayload({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.relationshipToUser,
    required this.aboutGp,
    required this.profileTag,
    required this.userId,
    required this.id,
  });

  factory PatientPayload.fromJson(Map<String, dynamic> json) {
    return PatientPayload(
      name: json["name"],
      dateOfBirth: json["dateOfBirth"],
      gender: json["gender"],
      relationshipToUser: json["relationshipToUser"],
      aboutGp: json["aboutGp"],
      profileTag: json["profileTag"],
      userId: json["userId"],
      id: json["id"],
    );
  }
}
