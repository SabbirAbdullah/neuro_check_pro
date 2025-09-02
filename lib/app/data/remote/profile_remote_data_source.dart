import 'package:neuro_check_pro/app/modules/assessment_history/models/assessment_history_model.dart';

import '../model/user_info_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserInfoModel> updateUser(int id, Map<String, dynamic> data, String token);
  Future<AssessmentHistoryModel> getSubmissions(int userId, String token);
}
