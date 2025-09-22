
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'package:neuro_check_pro/app/network/dio_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

// Google Sign-In Service Class
class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool isInitialize = false;
  static final  _dio = DioProvider.dioWithHeaderToken;

  static Future<void> initSignIn() async {
    if (!isInitialize) {
      await _googleSignIn.initialize(
        serverClientId:
            '145142242234-0iqpp3ufsp438j1enf2lk773naheikcn.apps.googleusercontent.com',
      );
    }
    isInitialize = true;
  }

  static Future<String?> signInWithGoogle() async {
    try {
      initSignIn();
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final idToken = googleUser.authentication.idToken;
      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization = await authorizationClient.authorizationForScopes(['email', 'profile']);

      final accessToken = authorization?.accessToken;

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );
      print("👉 Google idToken ${idToken}");
      print("👉 Access token ${accessToken}");


      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;


      final String? firebaseIdToken = await user?.getIdToken(true);

      if (firebaseIdToken == null) return null;

      print("✅ Firebase ID token: $firebaseIdToken");

      // 4️⃣ Send token to your backend
      final dio = Dio();
      final response = await dio.post(
        'https://neurocheckpro.com/api/auth/social-login',
        data: {'idToken': firebaseIdToken}, // backend expects this field
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      print("Backend response: ${response.data}");
      return firebaseIdToken;
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }




  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
      throw e;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}




class AppleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithApple() async {
    try {
      // Step 1: Request Apple credentials
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      // Step 2: Build OAuth credential for Firebase
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      // Step 3: Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(oauthCredential);

      return userCredential;
    } catch (e) {
      print("Apple Sign-In error: $e");
      return null;
    }
  }
}

