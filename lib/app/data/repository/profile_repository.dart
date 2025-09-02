import 'package:neuro_check_pro/app/modules/assessment_history/models/assessment_history_model.dart';

import '../model/user_info_model.dart';

abstract class ProfileRepository {
  Future<UserInfoModel> updateUser(int id, Map<String, dynamic> data, String token);
  Future<AssessmentHistoryModel> fetchSubmissions(int userId, String token);

}