import 'package:get/get.dart';

import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/assessment/models/question_model.dart';
import '../local/db/question_local_data_source.dart';
import '../local/preference/preference_manager.dart';
import '../remote/assessment_remote_data_source.dart';
import 'assessment_repository.dart';

class AssessmentRepositoryImpl implements AssessmentRepository {
  final AssessmentRemoteDataSource _remote =
  Get.find(tag: (AssessmentRemoteDataSource).toString());
  final PreferenceManager localDataSource =
  Get.find(tag: (PreferenceManager).toString());


  @override
  Future<AssessmentResponseModel> getAssessments(int userId, String token) {
    return _remote.getAssessments(userId,token);
  }

  @override
  Future<List<QuestionModel>> getQuestionsByAssessment(int assessmentId, String token) async {
    final response = await _remote.getQuestions(assessmentId,token);
    final filtered = response.payload
        .where((q) => q.assessmentId == assessmentId)
        .toList();
    filtered.sort((a, b) => a.order.compareTo(b.order));
    return filtered;
  }

  @override
  Future<int> getSavedProgress(int assessmentId) =>
      localDataSource.getProgress(assessmentId);

  @override
  Future<void> saveProgress(int assessmentId, int lastAnsweredIndex) =>
      localDataSource.saveProgress(assessmentId, lastAnsweredIndex);

  @override
  Future<void> saveAnswers(int assessmentId, Map<int, String> answers) =>
      localDataSource.saveAnswers(assessmentId, answers);

  @override
  Future<Map<int, String>> getAnswers(int assessmentId) =>
      localDataSource.getAnswers(assessmentId);
}






