import '../../modules/assessment/models/answer_model.dart';
import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/patient_info.dart';
import '../../modules/assessment/models/question_model.dart';
import '../model/answer_submission_model.dart';
import '../model/payment_model.dart';

abstract class AssessmentRepository {
  Future<AssessmentResponseModel> getAssessments(int userId, String token, String? type,);
  Future<List<QuestionModel>> getQuestionsByAssessment(int assessmentId, String token);
  Future<CheckoutResponse> getCheckoutUrl(String priceId,int assessmentId, int patientId, String token);
  Future<SubmissionResponse> submitAnswers(SubmissionRequest request, String token);
  // Future<Map<String, dynamic>> submitAnswer(AnswerModel answer, String token);
  Future<PatientResponse> fetchPatient(int patientId, String token);

  Future<int> getSavedProgress(int assessmentId);
  Future<void> saveProgress(int assessmentId, int lastAnsweredIndex);
  Future<void> saveAnswers(int assessmentId, Map<int, String> answers);
  Future<Map<int, String>> getAnswers(int assessmentId);
}