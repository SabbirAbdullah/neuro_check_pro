import 'dart:io';

import 'package:dio/dio.dart';

class DioErrorHandler {
  static String handle(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return "Request to API server was cancelled";
      case DioErrorType.connectionTimeout:
        return "Connection timeout with API server";
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return "Request timeout. Please try again.";
      case DioErrorType.badResponse:
        return _handleBadResponse(error.response);
      case DioErrorType.connectionError:
      case DioErrorType.unknown:
        if (error.error is SocketException) {
          return "No Internet connection";
        } else {
          return "Unexpected error occurred";
        }
      case DioErrorType.badCertificate:
        return "Bad certificate";
    }
  }

  static String _handleBadResponse(Response? response) {
    if (response == null) return "Unknown API error";

    switch (response.statusCode) {
      case 400:
        return response.data['message'] ?? "Bad request";
      case 401:
        return response.data['message'] ?? "Unauthorized";
      case 403:
        return response.data['message'] ?? "Forbidden";
      case 404:
        return "Resource not found";
      case 500:
        return "Internal server error";
      case 503:
        return "Service temporarily unavailable";
      default:
        return response.data['message'] ?? "Error: ${response.statusCode}";
    }
  }
}
