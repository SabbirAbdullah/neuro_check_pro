import 'package:get/get.dart';

import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/patient_profile/models/patient_form_model.dart';
import '../../modules/patient_profile/models/patient_profile_model.dart';
import '../remote/patient_remote_data_source.dart';

abstract class PatientRepository {
  Future<PatientResponseModel> addPatient(PatientRequestModel request, String token);
  Future<List<PatientModel>> fetchPatients(int id, String token);
  Future<PatientModel> updatePatientInfo(int id, Map<String, dynamic> data, String token);
}

