import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/question_model.dart';

abstract class AssessmentRepository {
  Future<AssessmentResponseModel> getAssessments(int userId, String token);
  Future<List<QuestionModel>> getQuestionsByAssessment(int assessmentId, String token);
  Future<int> getSavedProgress(int assessmentId);
  Future<void> saveProgress(int assessmentId, int lastAnsweredIndex);
  Future<void> saveAnswers(int assessmentId, Map<int, String> answers);
  Future<Map<int, String>> getAnswers(int assessmentId);
}