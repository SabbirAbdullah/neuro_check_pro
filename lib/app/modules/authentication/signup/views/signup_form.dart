// screens/signup_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/modules/dashboard/views/dashboard_view.dart';
import '../controllers/signup_controller.dart';

class SignupForm extends StatelessWidget {
   SignupForm({super.key});
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:CustomAppBar(title: 'Signup'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Sign Up",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),

            const Text(
              "Join NeuroCheckPro to begin your journey toward clarity and expert guidance. It only takes a minute!",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            _buildTextField("Your Name", controller.nameController),
            const SizedBox(height: 16),

            _buildTextField("Age", controller.ageController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 16),

            // Country Picker (fixed UK)
            const Text("Country", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/uk_flag.png', // add UK flag asset
                        width: 24,
                      ),
                      const SizedBox(width: 10),
                      const Text("United Kingdom"),
                    ],
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [

                Expanded(child: _buildTextField("State", controller.stateController)),
                const SizedBox(width: 16),
                Expanded(child: _buildTextField("Post code", controller.postcodeController)),
              ],
            ),
            const SizedBox(height: 16),

            _buildTextField("Street Address", controller.addressController),
            const SizedBox(height: 16),

            // Dropdown Role
            const Text("Are you a Parent or Carer?", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Obx(() => DropdownButtonFormField<String>(

              value: controller.selectedRole.value,
              hint: const Text("Choose your role"),
              items: controller.roleList
                  .map((role) =>
                  DropdownMenuItem(value: role, child: Text(role)))
                  .toList(),
              onChanged: (val) => controller.selectedRole.value = val,
              decoration: _dropdownDecoration(),
            )),
            const SizedBox(height: 16),

            // Dropdown How did you know?
            const Text("How did you know about us?", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Obx(() => DropdownButtonFormField<String>(
              value: controller.selectedOption.value,
              hint: const Text("Choose your option"),
              items: controller.howKnowList
                  .map((opt) =>
                  DropdownMenuItem(value: opt, child: Text(opt)))
                  .toList(),
              onChanged: (val) => controller.selectedOption.value = val,
              decoration: _dropdownDecoration(),
            )),
            const SizedBox(height: 16),
            Text('Password',style: TextStyle(color: Colors.grey),),
            Obx(() => TextField(
              onChanged: (value) => controller.password.value = value,
              obscureText: controller.isPasswordHidden.value,
              decoration: InputDecoration(
                labelText: 'Password',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.borderColor)

                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.borderColor)

                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
            )),
            const SizedBox(height: 16),
            Text('Confirm Password',style: TextStyle(color: Colors.grey),),
            Obx(() => TextField(
              onChanged: (value) => controller.confirmPassword.value = value,
              obscureText: controller.isConfirmPasswordHidden.value,
              decoration: InputDecoration(

                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.borderColor)

                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.borderColor)

                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isConfirmPasswordHidden.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: controller.toggleConfirmPasswordVisibility,
                ),
              ),
            )),
            const SizedBox(height: 30),

            // Sign up button
            ElevatedButton(
              onPressed: (){
                controller.submitForm();

                    showUKUserAlertDialog();


              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF114854),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Sign up",style: textButton_white,),
            ),
          ],
        ),
      ),
    );


  }

   void showUKUserAlertDialog() {
     Get.dialog(
       CupertinoAlertDialog(
         title: const Text(
           'NeuroCheckPro is designed for UK users',
           style: TextStyle(fontWeight: FontWeight.bold),
         ),
         content: const Padding(
           padding: EdgeInsets.only(top: 8.0),
           child: Text(
             'Assessments and diagnoses are tailored to UK clinical standards and may not align with practices in your country.',
             style: TextStyle(fontSize: 14),
           ),
         ),
         actions: <Widget>[
           CupertinoDialogAction(
             isDefaultAction: true,
             onPressed: () {
               Get.back(); // dismiss the dialog
             },
             child: const Text('Cancel',style: textButton_blue,),
           ),
           CupertinoDialogAction(
             isDestructiveAction: false,
             onPressed: () {
               showPrivacyPolicyDialog();
               // Handle Okay action
               // Get.back();
             },
             child: const Text('Okay',style: textButton_blue,),
           ),
         ],
       ),
       barrierDismissible: false,
     );
   }
   void showPrivacyPolicyDialog() {
     final RxBool isChecked = false.obs;

     Get.dialog(
       Obx(() => CupertinoAlertDialog(
         title: const Text(
           "Your Privacy Matters",
           style: TextStyle(fontWeight: FontWeight.bold),
         ),
         content: Column(
           children: [
             const SizedBox(height: 12),
             const Text(
               "We value your privacy and handle your personal data in accordance with GDPR. Your information will only be used for assessment and clinical purposes.",
               textAlign: TextAlign.center,
               style: TextStyle(fontSize: 14),
             ),
             const SizedBox(height: 16),
             Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Transform.scale(
                   scale: 0.9,
                   child: CupertinoCheckbox(
                     value: isChecked.value,
                     onChanged: (value) {
                       isChecked.value = value!;
                       if (value) {
                        controller.bottomNavigation();

                       }
                     },
                   ),
                 ),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.only(top: 4.0),
                     child: RichText(
                       text: TextSpan(
                         style: const TextStyle(
                             color: Colors.black, fontSize: 13.5),
                         children: [
                           const TextSpan(text: "I agree to our "),
                           TextSpan(
                             text: "Terms of Service",
                             style: const TextStyle(color: CupertinoColors.activeBlue),
                             recognizer: TapGestureRecognizer()
                               ..onTap = () {
                                 // TODO: Open Terms of Service
                               },
                           ),
                           const TextSpan(text: " and "),
                           TextSpan(
                             text: "Privacy Policy.",
                             style: const TextStyle(color: CupertinoColors.activeBlue),
                             recognizer: TapGestureRecognizer()
                               ..onTap = () {
                                 // TODO: Open Privacy Policy
                               },
                           ),
                         ],
                       ),
                     ),
                   ),
                 )
               ],
             ),
           ],
         ),
         actions: const [],
       )),
       barrierDismissible: false,
     );
   }


   // Reusable TextField widget
  Widget _buildTextField(String hint, TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppColors.appBarColor,
      decoration: InputDecoration(
        hintText: hint,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.borderColor)
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.borderColor)

        ),
      ),
    );
  }

  // Dropdown decoration
  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.borderColor)

      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.borderColor)

      ),
    );
  }
}


