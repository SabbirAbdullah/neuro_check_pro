import 'package:get/get.dart';

import '../../modules/assessment/models/answer_model.dart';
import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/patient_info.dart';
import '../../modules/assessment/models/question_model.dart';
import '../../modules/assessment_history/models/answers_history_model.dart';
import '../local/preference/preference_manager.dart';
import '../model/answer_submission_model.dart';
import '../model/payment_model.dart';
import '../remote/assessment_remote_data_source.dart';
import 'assessment_repository.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDataSource _remote =
      Get.find(tag: (AssessmentRemoteDataSource).toString());
  final PreferenceManager localDataSource =
      Get.find(tag: (PreferenceManager).toString());

  @override
  Future<AssessmentResponseModel> getAssessments(int userId, String token, String ? type,) {
    return _remote.getAssessments(userId, token,  type);
  }

  @override
  Future<List<QuestionModel>> getQuestionsByAssessment(
      int assessmentId, String token) async {
    final response = await _remote.getQuestions(assessmentId, token);
    final filtered =
        response.payload.where((q) => q.assessmentId == assessmentId).toList();
    filtered.sort((a, b) => a.order.compareTo(b.order));
    return filtered;
  }
  @override
  Future<CheckoutResponse> getCheckoutUrl(String priceId,int assessmentId, int patientId, String token){
    return _remote.createCheckout(priceId, assessmentId, patientId, token);
  }
  @override
  Future<SubmissionResponse> submitAnswers(SubmissionRequest request, String token) {
    return _remote.submitAnswers(request, token);
  }
  @override
  Future<PatientResponse> fetchPatient(int patientId, String token) {
    return _remote.getPatientById(patientId, token);
  }



  // Future<Map<String, dynamic>> submitAnswer(AnswerModel answer, String token) {
  //   return _remote.submitAnswer(answer, token);
  // }
  //



}
