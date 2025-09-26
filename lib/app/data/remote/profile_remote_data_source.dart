import 'dart:io';

import 'package:neuro_check_pro/app/modules/assessment_history/models/assessment_history_model.dart';

import '../../modules/assessment_history/models/answers_history_model.dart';
import '../model/upload_file_model.dart';
import '../model/user_info_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserInfoModel> updateUser(int id, Map<String, dynamic> data, String token);
  Future<AssessmentHistoryModel> getSubmissions(int userId, String token);
  Future<List<dynamic>> getBlogs(String token);
  Future<List<dynamic>> getBillingInfo(String token,int userId);

  Future<AnswerHistoryResponse> getAnswers({ required int assessmentId,
    required int patientId,
    required String token,
  });

  Future<UploadResponseModel> uploadFile(String token, File file);
}
