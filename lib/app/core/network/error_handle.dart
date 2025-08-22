import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  AppException({required this.message});
  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException(String message) : super(message: message);
}

class ApiException extends AppException {
  final int httpCode;
  final String status;
  ApiException({required this.httpCode, required this.status, required String message})
      : super(message: message);
}

Exception handleError(String error) {
  return AppException(message: error);
}

Exception handleDioError(DioException dioError) {
  switch (dioError.type) {
    case DioExceptionType.cancel:
      return AppException(message: "Request cancelled");
    case DioExceptionType.connectionTimeout:
      return AppException(message: "Connection timeout");
    case DioExceptionType.connectionError:
      return NetworkException("No internet connection");
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      return TimeoutException("Request timeout");
    case DioExceptionType.badResponse:
      return _parseErrorResponse(dioError);
    case DioExceptionType.badCertificate:
      return AppException(message: "Bad certificate");
    case DioExceptionType.unknown:
      if (dioError.error is SocketException) {
        return NetworkException("No internet connection");
      }
      return AppException(message: "Unexpected error");
  }
}

Exception _parseErrorResponse(DioException dioError) {
  final statusCode = dioError.response?.statusCode ?? 0;
  final message = dioError.response?.data['message'] ?? "Something went wrong";
  return ApiException(httpCode: statusCode, status: '', message: message);
}
