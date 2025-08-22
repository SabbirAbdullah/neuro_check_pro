import '../../modules/authentication/signin/model/login_model.dart';
import '../../modules/authentication/signup/models/otp_model.dart';
import '../../modules/authentication/signup/models/signup_model.dart';
import '../model/user_info_model.dart';
import '../remote/auth_remote_data_impl.dart';

abstract class AuthenticationRepository {
  Future<LoginResponse> login(LoginRequest request);
  Future<SendOtpResponse> sendOtp(SendOtpRequest request);
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request);
  Future<SignupResponse> signup(SignupRequest request);
  Future<UserInfoResponse> getUserById(int id, String token);

}


