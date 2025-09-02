import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/patient_profile/models/patient_form_model.dart';
import '../../modules/patient_profile/models/patient_profile_model.dart';

abstract class PatientRemoteDataSource {
  Future<PatientResponseModel> addPatient(PatientRequestModel request, String token);
  Future<List<PatientModel>> fetchPatients(int id, String token);
  Future<PatientModel> updatePatient(int id, Map<String, dynamic> data, String token);
}
