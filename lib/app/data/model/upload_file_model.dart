
// Represents the entire API response for a file upload.
class UploadResponseModel {
  final String message;
  final int statusCode;
  final Payload payload;

  UploadResponseModel({
    required this.message,
    required this.statusCode,
    required this.payload,
  });

  factory UploadResponseModel.fromMap(Map<String, dynamic> json) {
    return UploadResponseModel(
      message: json['message'] as String,
      statusCode: json['statusCode'] as int,
      payload: Payload.fromMap(json['payload'] as Map<String, dynamic>),
    );
  }
}

// Represents the payload part of the API response, containing file details.
class Payload {
  final String filename;
  final String path;

  Payload({
    required this.filename,
    required this.path,
  });

  factory Payload.fromMap(Map<String, dynamic> json) {
    return Payload(
      filename: json['filename'] as String,
      path: json['path'] as String,
    );
  }
}

// class UploadResponse {
//   final String message;
//   final int statusCode;
//   final String filename;
//   final String path;
//
//   UploadResponse({
//     required this.message,
//     required this.statusCode,
//     required this.filename,
//     required this.path,
//   });
//
//   factory UploadResponse.fromJson(Map<String, dynamic> json) {
//     return UploadResponse(
//       message: json['message'] ?? '',
//       statusCode: json['statusCode'] ?? 0,
//       filename: json['payload']?['filename'] ?? '',
//       path: json['payload']?['path'] ?? '',
//     );
//   }
// }
