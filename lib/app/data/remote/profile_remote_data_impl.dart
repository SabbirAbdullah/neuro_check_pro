import 'dart:io';

import 'package:dio/dio.dart';
import 'package:neuro_check_pro/app/data/remote/profile_remote_data_source.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/models/assessment_history_model.dart';

import '../../core/network/error_handle.dart';
import '../../modules/assessment_history/models/answers_history_model.dart';
import '../../network/dio_provider.dart';
import '../model/upload_file_model.dart';
import '../model/user_info_model.dart';

class ProfileRemoteDataImpl implements ProfileRemoteDataSource {
  final Dio _dio = DioProvider.dioWithHeaderToken;

  @override
  Future<UserInfoModel> updateUser(int id, Map<String, dynamic> data,
      String token) async {
    try {
      final response = await _dio.put(
        "/users/$id",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      return UserInfoResponse
          .fromJson(response.data)
          .payload;
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<AssessmentHistoryModel> getSubmissions(int userId,
      String token) async {
    try {
      final response = await _dio.get(
        "/submissions",
        queryParameters: {"userId": userId,"limit":50},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      return AssessmentHistoryModel.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<List<dynamic>> getBlogs(String token) async {
    try {
      final response = await _dio.get(
        "/blogs",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return response.data['payload'];
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<List<dynamic>> getBillingInfo(String token,int userId) async {
    try {
      final response = await _dio.get(
        "/payment",
        queryParameters: {"userId": userId},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      return response.data['payload'];
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }


  @override
  Future<AnswerHistoryResponse> getAnswers({ required int assessmentId,
    required int patientId,
    required String token,
  }) async {
    try {
      final response = await _dio.get(
        "/answers",
        queryParameters: {
          "assessmentId": assessmentId,
          "patientId": patientId,
          "limit":1000,
        },
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      return AnswerHistoryResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }
  @override
  Future<UploadResponseModel> uploadFile(String token, File file) async {
    try {
      final fileName = file.path.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      final response = await _dio.post(
        '/upload', // use full URL
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            // don't set Content-Type, Dio will handle it
          },
        ),
      );

      return UploadResponseModel.fromMap(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }



}