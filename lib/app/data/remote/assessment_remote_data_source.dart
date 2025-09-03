import '../../modules/assessment/models/answer_model.dart';
import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/patient_info.dart';
import '../../modules/assessment/models/question_model.dart';
import '../model/answer_submission_model.dart';
import '../model/payment_model.dart';

abstract class AssessmentRemoteDataSource {
  Future<AssessmentResponseModel> getAssessments(int userId, String token, String? type);
  Future<QuestionResponseModel> getQuestions(int assessmentId,String token);
  Future<CheckoutResponse> createCheckout(String priceId,int assessmentId, int patientId, String token);
  Future<PatientResponse> getPatientById(int patientId, String token);
  // Future<Map<String, dynamic>> submitAnswer(AnswerModel answer, String token);
  Future<SubmissionResponse> submitAnswers(SubmissionRequest request, String token);
}
