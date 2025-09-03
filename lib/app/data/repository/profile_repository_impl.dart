
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/remote/profile_remote_data_source.dart';
import 'package:neuro_check_pro/app/data/repository/profile_repository.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/models/assessment_history_model.dart';

import '../../modules/billing_info/models/billing_info_model.dart';
import '../../modules/dashboard/models/blog_model.dart';
import '../local/preference/preference_manager.dart';
import '../model/user_info_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remote =
  Get.find(tag: (ProfileRemoteDataSource).toString());
  final PreferenceManager localDataSource =
  Get.find(tag: (PreferenceManager).toString());


  Future<UserInfoModel> updateUser(int id, Map<String, dynamic> data, String token) {
    return _remote.updateUser(id, data, token);
  }

  @override
  Future<AssessmentHistoryModel> fetchSubmissions(int userId, String token) {
    return _remote.getSubmissions(userId, token);
  }

  @override
  Future<List<BlogModel>> getBlogs(String token) async {
    final data = await _remote.getBlogs(token);
    return data.map<BlogModel>((json) => BlogModel.fromJson(json)).toList();
  }

  @override
  Future<List<BillingInfoModel>> fetchBillingInfo(String token,int userId ) async {
    final data = await _remote.getBillingInfo(token,userId);
    return data.map<BillingInfoModel>((json) => BillingInfoModel.fromJson(json)).toList();
  }
}