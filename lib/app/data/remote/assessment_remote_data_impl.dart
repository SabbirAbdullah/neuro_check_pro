import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../core/network/error_handle.dart';
import '../../modules/assessment/models/answer_model.dart';
import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/patient_info.dart';
import '../../modules/assessment/models/question_model.dart';
import '../../modules/assessment_history/models/answers_history_model.dart' show AnswerHistoryResponse;
import '../../network/dio_provider.dart';
import '../model/answer_submission_model.dart';
import '../model/payment_model.dart';
import 'assessment_remote_data_source.dart';


class AssessmentRemoteDataSourceImpl implements AssessmentRemoteDataSource {
  final Dio _dio = DioProvider.dioWithHeaderToken; // token injected manually


  @override
  Future<AssessmentResponseModel> getAssessments(int userId,
      String token,  String? type,) async {
    try {
      final response = await _dio.get(
        "/assessments",
        data: {"id": userId},
        queryParameters: {"type":type},
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
  Future<QuestionResponseModel> getQuestions(int assessmentId,
      String token) async {
    try {
      final response = await _dio.get(
        "/questionnaires",
        queryParameters: {"assessmentId": assessmentId, "limit": 100},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return QuestionResponseModel.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<CheckoutResponse> createCheckout(String priceId,int assessmentId, int patientId, String token) async {
    try {
      final response = await _dio.post(
        "/payment/checkout",
        data: {
          "priceId": priceId,
          "assessmentId":assessmentId,
          "patientId":patientId

        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      return CheckoutResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<PatientResponse> getPatientById(int patientId, String token) async {
    try {
      final response = await _dio.get(
        "/patient",
        queryParameters: {"id": patientId},
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      return PatientResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
  // Future<Map<String, dynamic>> submitAnswer(AnswerModel answer, String token) async {
  //   try {
  //     final response = await _dio.post(
  //       "/answers",
  //       data: answer.toJson(),
  //       options: Options(
  //         headers: {"Authorization": "Bearer $token"},
  //       ),
  //     );
  //     return response.data;
  //   } on DioException catch (dioError) {
  //     throw handleDioError(dioError);
  //   } catch (e) {
  //     throw handleError(e.toString());
  //   }
  // }


  @override
  Future<SubmissionResponse> submitAnswers(SubmissionRequest request, String token) async {
    try {
      final response = await _dio.post(
        "/submissions",
        data: request.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      return SubmissionResponse.fromJson(response.data);
    }
    on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }



}