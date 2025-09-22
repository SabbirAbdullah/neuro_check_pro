// screens/signin_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';

import '../../../../core/values/text_styles.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../controller/controller.dart';
import '../controller/google_service.dart';
import '../controller/signin_controller.dart';
import '../widgets/toggle_email_phone.dart';


class SignInView extends StatefulWidget {
  SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool _loading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() => _loading = true);
    try {
      final String? userEmail = await GoogleSignInService.signInWithGoogle();

      if (userEmail != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signed in as $userEmail")),
        );

        // 👉 Navigate to home page or dashboard
        // Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sign-in was cancelled")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sign-in failed: $e")),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  // Future<void> _handleGoogleSignIn() async {
  //   setState(() => _loading = true);
  //
  //   try {
  //     // Call the new service
  //     final backendResponse = await GoogleSignInService.signInWithGoogle();
  //
  //     if (backendResponse != null) {
  //       final user = backendResponse['user'];
  //       final token = backendResponse['token'];
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text("Signed in as ${user?['name'] ?? 'Unknown'}"),
  //         ),
  //       );
  //
  //       // 👉 Store token locally if needed
  //       // await SharedPreferences.getInstance()
  //       //   ..setString('jwt', token);
  //
  //       // 👉 Navigate to home page or dashboard
  //       // Navigator.pushReplacementNamed(context, '/home');
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Sign-in cancelled")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Sign-in failed: $e")),
  //     );
  //   } finally {
  //     setState(() => _loading = false);
  //   }
  // }
  Future<void> _handleSignOut() async {
    await GoogleSignInService.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Signed out")),
    );
  }

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

            OutlinedButton.icon(
              onPressed: (){
                _handleGoogleSignIn();
                // Get.to(()=>EmailLoginScreen());
                // controller.signInWithGoogle();
              },

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
            // OutlinedButton.icon(
            //   onPressed: controller.signInWithFacebook,
            //   icon: const Icon(Icons.facebook, color: Colors.blue),
            //   label: const Text(
            //     "Sign in with Facebook",
            //     style: signInOptionTextButton,
            //   ),
            //   style: OutlinedButton.styleFrom(
            //     minimumSize: const Size(double.infinity, 50),
            //     side:  BorderSide(
            //       color: AppColors.borderColor, // ✅ border color here
            //       // optional thickness
            //     ),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 30),

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




// class EmailLoginScreen extends StatelessWidget {
//   final EmailAuthController controller = Get.put(EmailAuthController());
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   final RxBool isLoginMode = true.obs;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Obx(() => Text(isLoginMode.value ? "Login" : "Sign Up"))),
//       body: Obx(() {
//         return controller.isLoading.value
//             ? const Center(child: CircularProgressIndicator())
//             : Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               if (!isLoginMode.value)
//                 TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(labelText: "Name"),
//                 ),
//               TextField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: "Email"),
//               ),
//               TextField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(labelText: "Password"),
//                 obscureText: true,
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (isLoginMode.value) {
//                     controller.login(
//                       emailController.text.trim(),
//                       passwordController.text.trim(),
//                     );
//                   } else {
//                     controller.signUp(
//                       nameController.text.trim(),
//                       emailController.text.trim(),
//                       passwordController.text.trim(),
//                     );
//                   }
//                 },
//                 child: Text(isLoginMode.value ? "Login" : "Sign Up"),
//               ),
//               TextButton(
//                 onPressed: () {
//                   isLoginMode.value = !isLoginMode.value;
//                 },
//                 child: Text(isLoginMode.value
//                     ? "Don't have an account? Sign Up"
//                     : "Already have an account? Login"),
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

