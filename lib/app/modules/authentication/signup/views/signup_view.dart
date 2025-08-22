// screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/text_styles.dart';
import '../controllers/signup_controller.dart';
import '../widgets/email/signup_email.dart';
import '../widgets/phone/signup_phone.dart';

class SignupView extends StatelessWidget {
   SignupView({super.key});
final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 50),
              // Logo Circle
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFF114854),
                child: Text(
                  "N",
                  style: TextStyle(fontSize: 36, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),

              // Description
              const Text(
                "You can participate in initial\nassessment after quick sign up.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 40),

              // Phone Signup Button
              ElevatedButton.icon(
                onPressed: (){
                  Get.to(()=>SignupPhone());
                },
                icon: const Icon(Icons.phone,color: Colors.white,),
                label: const Text("Sign up with Phone",style: textButton_white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114854),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email Signup Button
              ElevatedButton.icon(
                onPressed: (){
                  Get.to(()=> SignUpEmail());
                },
                icon: const Icon(Icons.email,color: Colors.white,),
                label: const Text("Sign up with Email",style: textButton_white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114854),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // OR Text
              const Text(
                "Or",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),

              // Google Sign In
              OutlinedButton.icon(
                onPressed: controller.signInWithGoogle,
                icon: Image.asset('assets/google.png', height: 20),
                label: const Text("Sign in with Google",style:signInOptionTextButton ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side:  BorderSide(
                    color: AppColors.borderColor, // ✅ border color here
                    // optional thickness
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Apple Sign In
              OutlinedButton.icon(
                onPressed: controller.signInWithApple,
                icon: const Icon(Icons.apple, color: Colors.black),
                label: const Text("Sign in with Apple",style: signInOptionTextButton),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side:  BorderSide(
                    color: AppColors.borderColor, // ✅ border color here
                    // optional thickness
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Facebook Sign In
              OutlinedButton.icon(
                onPressed: controller.signInWithFacebook,
                icon: const Icon(Icons.facebook, color: Colors.blue),
                label: const Text("Sign in with Facebook",style: signInOptionTextButton),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side:  BorderSide(
                    color: AppColors.borderColor, // ✅ border color here
                    // optional thickness
                  ),
                ),
              ),

              const Spacer(),

              // Already have account?
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Do you have account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xFF114854),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
