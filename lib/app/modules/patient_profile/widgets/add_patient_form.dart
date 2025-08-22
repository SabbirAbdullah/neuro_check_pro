import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_button.dart';
import 'package:neuro_check_pro/app/modules/patient_profile/models/patient_profile_model.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/widgets/custom_loading.dart';
import '../controllers/patient_profile_controller.dart';

class AddPatientForm extends StatelessWidget {
  final PatientProfileController controller =
      Get.put(PatientProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Add Child'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Fill out this form",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Start your journey with NeuroCheckPro to clarity and expert insights. Creating your profile takes just a minute!",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 30),
            _buildInputField("Name", controller.nameController),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => controller.showCupertinoDatePicker(context),
              child: AbsorbPointer(
                child: _buildInputField(
                  "Date of Birth",
                  controller.dobController,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Gender',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Obx(() {
              return CustomDropdown<String>(
                decoration: CustomDropdownDecoration(
                    closedBorder: Border.all(
                      color: AppColors.borderColor,
                    ),
                    closedBorderRadius: BorderRadius.circular(30)),
                hintText: "Select Gender",
                items: ["Male", "Female", "Other"],
                initialItem: controller.gender.value.isEmpty
                    ? null
                    : controller.gender.value,
                onChanged: (val) {
                  controller.gender.value = val!;
                },
              );
            }),
            const SizedBox(height: 20),
            const Text('Relationship to User',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            Obx(() => CustomDropdown<String>(
                  decoration: CustomDropdownDecoration(
                      closedBorder: Border.all(
                        color: AppColors.borderColor,
                      ),
                      closedBorderRadius: BorderRadius.circular(30)),
                  initialItem: controller.relationship.value.isEmpty
                      ? null
                      : controller.relationship.value,
                  items: ["Parent", "Guardian", "Relative"],
                  onChanged: (val) => controller.relationship.value = val ?? '',
                )),
            const SizedBox(height: 20),
            _buildInputField(
              "About your GP",
              controller.gpController,
              hint: "Do you want to tell us about your GP?",
            ),
            const SizedBox(height: 20),
            _buildInputField(
              "Profile Tag (optional):",
              controller.tagController,
              hint: "ex. George - ADHD",
            ),
            const SizedBox(height: 40),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CustomLoading());
              }
              return CustomButton(
                  text: "Submit",
                  onPressed: () {
                    controller.submitNewChild();
                  });
            }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller,
      {String? hint, Widget? suffixIcon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.borderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: AppColors.borderColor)),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
