import 'package:neuro_check_pro/app/modules/assessment_history/models/assessment_history_model.dart';

import '../../modules/billing_info/models/billing_info_model.dart';
import '../../modules/dashboard/models/blog_model.dart';
import '../model/user_info_model.dart';

abstract class ProfileRepository {
  Future<UserInfoModel> updateUser(int id, Map<String, dynamic> data, String token);
  Future<AssessmentHistoryModel> fetchSubmissions(int userId, String token);
  Future<List<BlogModel>> getBlogs(String token);
  Future<List<BillingInfoModel>> fetchBillingInfo(String token,int userId );
}