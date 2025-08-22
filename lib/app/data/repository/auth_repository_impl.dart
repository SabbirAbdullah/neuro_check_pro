import 'package:get/get.dart';

import '../../modules/authentication/signin/model/login_model.dart';
import '../../modules/authentication/signup/models/otp_model.dart';
import '../../modules/authentication/signup/models/signup_model.dart';
import '../model/user_info_model.dart';
import '../remote/auth_remote_data_source.dart';
import 'auth_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteSource =
  Get.find(tag: (AuthenticationRemoteDataSource).toString());

  @override
  Future<LoginResponse> login(LoginRequest request) {
    return _remoteSource.login(request);
  }

  @override
  Future<UserInfoResponse> getUserById(int id, String token) {
    return _remoteSource.getUserById(id, token);
  }

  Future<SendOtpResponse> sendOtp(SendOtpRequest request) {
    return _remoteSource.sendOtp(request);
  }

  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) {
    return _remoteSource.verifyOtp(request);
  }


  Future<SignupResponse> signup(SignupRequest request) {
    return _remoteSource.signup(request);
  }
}
