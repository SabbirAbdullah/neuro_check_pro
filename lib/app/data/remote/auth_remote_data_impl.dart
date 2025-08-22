// data/remote/authentication_remote_data.dart
import 'package:dio/dio.dart';
import 'package:neuro_check_pro/app/network/dio_provider.dart';
import '../../core/network/error_handle.dart';
import '../../modules/authentication/signin/model/login_model.dart';
import '../../modules/authentication/signup/models/otp_model.dart';
import '../../modules/authentication/signup/models/signup_model.dart';
import '../model/user_info_model.dart';
import 'auth_remote_data_source.dart';

class AuthenticationRemoteDataImpl implements AuthenticationRemoteDataSource {
  final Dio _dio = DioProvider.dioWithHeaderToken;

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        "/auth/login",
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<UserInfoResponse> getUserById(int id, String token) async {
    try {
      final response = await _dio.get(
        "/users/$id",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      return UserInfoResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<SendOtpResponse> sendOtp(SendOtpRequest request) async {
    try {
      final response =
          await _dio.post("/auth/send-otp", data: request.toJson());
      return SendOtpResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response =
          await _dio.post("/auth/verify-otp", data: request.toJson());
      return VerifyOtpResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }

  @override
  Future<SignupResponse> signup(SignupRequest request) async {
    try {
      final response = await _dio.post(
        "/auth/signup",
        data: request.toJson(),
      );
      return SignupResponse.fromJson(response.data);
    } on DioException catch (dioError) {
      throw handleDioError(dioError);
    } catch (e) {
      throw handleError(e.toString());
    }
  }
}
