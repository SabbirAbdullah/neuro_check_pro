
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/repository/patient_repository.dart';

import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/patient_profile/models/patient_form_model.dart';
import '../../modules/patient_profile/models/patient_profile_model.dart';
import '../remote/patient_remote_data_source.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource _remote =
  Get.find(tag: (PatientRemoteDataSource).toString());

  @override
  Future<PatientResponseModel> addPatient(PatientRequestModel request, String token) {
    return _remote.addPatient(request,token);
  }

  @override
  Future<List<PatientModel>> fetchPatients(int id, String token) {
    return _remote.fetchPatients(id,token);
  }

}