// screens/signin_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';

import '../../../../core/values/text_styles.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../controller/signin_controller.dart';
import '../widgets/toggle_email_phone.dart';


class SignInView extends StatelessWidget {
  SignInView({super.key});
  final SignInController controller = Get.put(SignInController(), permanent: true);


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0,scrolledUnderElevation: 0,),
      body:SingleChildScrollView(
        padding:  EdgeInsets.all(24),
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
            // Toggle
            Obx(() => ToggleEmailPhone(
              selected: controller.loginMethod.value,
              onChanged: (val) => controller.loginMethod.value = val,
            )),
            const SizedBox(height: 20),

// Email or Phone Input
            Obx(() {
              if (controller.loginMethod.value == "Email") {
                return TextField(
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),
                  cursorColor: AppColors.appBarColor,
                  controller: controller.emailOrPhoneController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email_outlined),
                    hintText: "Your E-mail",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                  ),
                );
              } else {
                return  IntlPhoneField(
                  style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  pickerDialogStyle: PickerDialogStyle(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(20),
                    searchFieldCursorColor: AppColors.appBarColor,
                    searchFieldInputDecoration: InputDecoration(
                      hintText: 'Search Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.appBarColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: AppColors.appBarColor),
                      ),
                    ),
                    listTileDivider: Divider(
                      color: AppColors.dividerColor,
                      thickness: 0.5,
                    ),
                    countryNameStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  controller: controller.emailOrPhoneController,
                  textAlign: TextAlign.justify,
                  dropdownIcon: const Icon(Icons.keyboard_arrow_down_outlined),
                  cursorColor: AppColors.appBarColor,
                  disableLengthCheck: true,
                  decoration: InputDecoration(
                    hintText: "Your Phone",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.appBarColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.appBarColor),
                    ),
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  ),
                  initialCountryCode: 'GB', // default
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    controller.countryCode = "+${country.dialCode}";
                    print("Updated Country Code: ${controller.countryCode}");
                  },
                );

              }
            }),

            const SizedBox(height: 20),

            // Password with toggle
            Obx(() => TextField(
              cursorColor: AppColors.appBarColor,
              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
              controller: controller.passwordController,
              obscureText: !controller.isPasswordVisible.value,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(controller.isPasswordVisible.value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: controller.togglePasswordVisibility,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.borderColor)

                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.borderColor)

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
         Obx((){
           if (controller.isLoading.value) {
             return Center(child: CustomLoading());
           }

           return   ElevatedButton(
             onPressed:()async {
              await controller.login();

             },
             style: ElevatedButton.styleFrom(
               backgroundColor: const Color(0xFF114854),
               foregroundColor: Colors.white,
               minimumSize: const Size(double.infinity, 50),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(30),
               ),
             ),
             child: const Text("Sign In",style: textButton_white,),
           );
         }),
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
                    borderRadius: BorderRadius.circular(30,),
                  ),
                  side: BorderSide(color: AppColors.borderColor)
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
              label: const Text(
                "Sign in with Facebook",
                style: signInOptionTextButton,
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side:  BorderSide(
                  color: AppColors.borderColor, // ✅ border color here
                  // optional thickness
                ),
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

    );
  }
}
