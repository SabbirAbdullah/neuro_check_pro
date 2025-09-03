import 'package:dio/dio.dart';
import 'package:neuro_check_pro/app/data/remote/profile_remote_data_source.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/models/assessment_history_model.dart';

import '../../core/network/error_handle.dart';
import '../../network/dio_provider.dart';
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
        queryParameters: {"userId": userId},
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
}