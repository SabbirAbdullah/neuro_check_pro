
import 'package:flutter/cupertino.dart';
// models/patient_model.dart
class PatientModel {
  final int id;
  final String name;
  final String ? imageUrl;
  final String dateOfBirth;
  final String gender;
  final String relationshipToUser;
  final String aboutGp;
  final String profileTag;
  final int userId;

  PatientModel({
    required this.id,
    this.imageUrl,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.relationshipToUser,
    required this.aboutGp,
    required this.profileTag,
    required this.userId,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json["imageUrl"],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      relationshipToUser: json['relationshipToUser'],
      aboutGp: json['aboutGp'],
      profileTag: json['profileTag'],
      userId: json['userId'],
    );
  }

  String initials(String name) {
    final parts = name.split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

}




class PatientProfileModel {
  final String id;
  final String name;
  final String? imageUrl; // nullable if no image uploaded
  final String gender;
  final DateTime dob;
  final String ? relation;
  final String ? gp;
  final String ? tag;

  PatientProfileModel({
    required this.id,
    required this.name,
    this.imageUrl,
    this.relation,
    this.gp,
    this.tag,
    required this.gender,
    required this.dob,
  });

  // Factory from JSON
  factory PatientProfileModel.fromJson(Map<String, dynamic> json) {
    return PatientProfileModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      relation: json['relation'] ?? '',
      gp: json['gp'] ?? '',
      tag: json['tag'] ?? '',
      imageUrl: json['profileImageUrl'],
      gender: json['gender'] ?? '',
      dob: DateTime.tryParse(json['dob'] ?? '') ?? DateTime.now(),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'relation':relation,
      'imageUrl': imageUrl,
      'gender': gender,
      'dob': dob.toIso8601String(),
    };
  }


}
