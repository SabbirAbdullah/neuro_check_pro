// data/remote/patient_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/data/remote/patient_remote_data_source.dart';

import '../../core/network/error_handle.dart';
import '../../modules/assessment/models/assessment_model.dart';
import '../../modules/patient_profile/models/patient_form_model.dart';
import '../../modules/patient_profile/models/patient_profile_model.dart';
import '../../network/dio_provider.dart';
import '../repository/pref_repository.dart';

class PatientRemoteDataSourceImpl implements PatientRemoteDataSource {
  final Dio _dio =
      DioProvider.dioWithHeaderToken; // we’ll inject token manually

  @override
  Future<PatientResponseModel> addPatient(
      PatientRequestModel request, String token) async {
    try {
      final response = await _dio.post(
        "/patient",
        data: request.toJson(),
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );
      return PatientResponseModel.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<List<PatientModel>> fetchPatients(int id, String token) async {
    try {
      final response = await _dio.get(
        '/patient?userId=$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List data = response.data['payload'];
      return data.map((json) => PatientModel.fromJson(json)).toList();
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }


  @override
  Future<PatientModel> updatePatient(int id, Map<String, dynamic> data, String token) async {
    try {
      final response = await _dio.put(
        '/patient/$id',
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

        return PatientModel.fromJson(response.data['payload']);
      } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }
}
