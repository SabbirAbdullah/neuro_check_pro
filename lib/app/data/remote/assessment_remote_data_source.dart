import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/question_model.dart';

abstract class AssessmentRemoteDataSource {
  Future<AssessmentResponseModel> getAssessments(int userId, String token);
  Future<QuestionResponseModel> getQuestions(int assessmentId,String token);
}
