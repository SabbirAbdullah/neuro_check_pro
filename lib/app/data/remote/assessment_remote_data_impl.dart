import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/network/error_handle.dart';
import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/question_model.dart';
import '../../network/dio_provider.dart';
import 'assessment_remote_data_source.dart';


class AssessmentRemoteDataSourceImpl implements AssessmentRemoteDataSource {
  final Dio _dio = DioProvider.dioWithHeaderToken; // token injected manually


  @override
  Future<AssessmentResponseModel> getAssessments(int userId, String token) async {
    try {
      final response = await _dio.get(
        "/assessments",
        data: {"id": userId},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      return AssessmentResponseModel.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }


  @override
  Future<QuestionResponseModel> getQuestions(int assessmentId,String token) async {
    try {
      final response = await _dio.get(
        "/questionnaires",
        queryParameters: {"assessmentId": assessmentId},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return QuestionResponseModel.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }
}
