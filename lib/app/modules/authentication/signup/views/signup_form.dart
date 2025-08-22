// screens/signup_screen.dart
import 'package:country_picker/country_picker.dart';
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
  final SignupController controller = Get.find<SignupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Signup'),
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
            const Text("Name", style: TextStyle(color: Colors.grey)),
            _buildTextField(controller.nameController),
            const SizedBox(height: 16),
            const Text("Email", style: TextStyle(color: Colors.grey)),
            _buildTextField(controller.emailController),
            const SizedBox(height: 16),
            const Text("Age", style: TextStyle(color: Colors.grey)),
            _buildTextField(controller.ageController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 16),

            // Country Picker (fixed UK)
            const Text("Country", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Obx(() => GestureDetector(
                  onTap: () {
                    pickCountry(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              controller.selectedCountry.value.flagEmoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: 10),
                            Text(controller.selectedCountry.value.name),
                          ],
                        ),
                        const Icon(CupertinoIcons.chevron_down),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("State", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 6),
                      _buildTextField(controller.stateController)
                    ],
                  ),
                ),
                const SizedBox(width: 16), // space between fields

                // Post code field
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Post code",
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 6),
                      _buildTextField(controller.postcodeController)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text("Street Address ", style: TextStyle(color: Colors.grey)),
            _buildTextField(controller.addressController),
            const SizedBox(height: 16),

            // Dropdown Role
            const Text("Are you a Parent or Carer?",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Obx(() => DropdownButtonFormField<String>(
                  dropdownColor: Colors.white,
                  value: controller.selectedRole.value,
                  hint: const Text("Choose your role"),
                  items: controller.roleList
                      .map((role) => DropdownMenuItem(
                          value: role,
                          child: Text(
                            role,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )))
                      .toList(),
                  onChanged: (val) => controller.selectedRole.value = val,
                  decoration: _dropdownDecoration(),
                )),
            const SizedBox(height: 16),

            // Dropdown How did you know?
            const Text("How did you know about us?",
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 6),
            Obx(() => DropdownButtonFormField<String>(
                  value: controller.selectedOption.value,
                  hint: const Text("Choose your option"),
                  items: controller.howKnowList
                      .map((opt) => DropdownMenuItem(
                          value: opt,
                          child: Text(
                            opt,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          )))
                      .toList(),
                  onChanged: (val) => controller.selectedOption.value = val,
                  decoration: _dropdownDecoration(),
                )),
            const SizedBox(height: 16),
            Text(
              'Password',
              style: TextStyle(color: Colors.grey),
            ),
            Obx(() => TextField(
                  onChanged: (value) => controller.password.value = value,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: AppColors.borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: AppColors.borderColor)),
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
            Text(
              'Confirm Password',
              style: TextStyle(color: Colors.grey),
            ),
            Obx(() => TextField(
                  onChanged: (value) =>
                      controller.confirmPassword.value = value,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: AppColors.borderColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: AppColors.borderColor)),
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
              onPressed: () {
                controller.submitForm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF114854),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Sign up",
                style: textButton_white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable TextField widget
  Widget _buildTextField(TextEditingController controller,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: AppColors.appBarColor,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.borderColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.borderColor)),
      ),
    );
  }

  // Dropdown decoration
  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.borderColor)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.borderColor)),
    );
  }

  void pickCountry(context) {
    showCountryPicker(
      context: Get.context!,
      showPhoneCode: false, // 🚀 Hide the phone code
      countryListTheme: CountryListThemeData(
        inputDecoration: InputDecoration(
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
        flagSize: 24,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.black87),
        bottomSheetHeight: MediaQuery.of(context).size.height * .5,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      onSelect: (Country country) {
        controller.selectedCountry.value = country;
      },
    );
  }
}
