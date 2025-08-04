// screens/signin_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';

import '../../../../core/values/text_styles.dart';
import '../controller/signin_controller.dart';


class EmailSignIn extends StatelessWidget {
  EmailSignIn({super.key});
final SignInController controller = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Logo
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xFF114854),
                child: Text("N", style: TextStyle(fontSize: 28, color: Colors.white)),
              ),
              const SizedBox(height: 30),

              // Title
              const Text(
                "Sign In",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              const Text(
                "Sign in to continue your assessment journey or check your previous results.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 30),

              // Email or Phone
              TextField(
                controller: controller.emailOrPhoneController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  hintText: "Your E-mail or Phone",
                  border: OutlineInputBorder(borderSide: BorderSide(color:AppColors.borderColor,width: 1 ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password with toggle
              Obx(() => TextField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              )),
              const SizedBox(height: 10),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: controller.forgotPassword,
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Color(0xFF114854), fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sign In Button
              ElevatedButton(
                onPressed: controller.signIn,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF114854),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Sign In",style: textButton_white,),
              ),
              const SizedBox(height: 20),

              // OR
              const Center(child: Text("Or", style: TextStyle(color: Colors.grey))),
              const SizedBox(height: 20),

              // Google Sign In
              OutlinedButton.icon(
                onPressed: controller.signInWithGoogle,
                icon: Image.asset('assets/google.png', height: 20),
                label: const Text("Sign in with Google",style: signInOptionTextButton,),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Apple Sign In
              OutlinedButton.icon(
                onPressed: controller.signInWithApple,
                icon: const Icon(Icons.apple, color: Colors.black),
                label: const Text("Sign in with Apple",style: signInOptionTextButton,),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Facebook Sign In
              OutlinedButton.icon(
                onPressed: controller.signInWithFacebook,
                icon: const Icon(Icons.facebook, color: Colors.blue),
                label: const Text("Sign in with Facebook",style: signInOptionTextButton,),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Sign Up navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have account? ", style: TextStyle(color: Colors.grey)),
                  GestureDetector(
                    onTap: controller.goToSignUp,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF114854),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
