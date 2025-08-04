import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

import '../controllers/primary_assessment_controller.dart';
import 'child_profile.dart';


class NewProfileView extends StatelessWidget {
  final PrimaryAssessmentController controller = Get.put(PrimaryAssessmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(title: 'New Profile'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Text("Fill out this form",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              "Start your journey with NeuroCheckPro to clarity and expert insights. Creating your profile takes just a minute!",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            _buildInputField("Your Name:", controller.nameController),
            const SizedBox(height: 20),

            GestureDetector(
              onTap: () => controller.showCupertinoDatePicker(context),
              child: AbsorbPointer(
                child: _buildInputField(
                  "Date of Birth:",
                  controller.dobController,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Obx(() => DropdownButtonFormField<String>(
              decoration: _inputDecoration("Gender:"),
              value: controller.gender.value.isEmpty ? null : controller.gender.value,
              items: ["Male", "Female", "Other"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => controller.gender.value = val ?? '',
            )),
            const SizedBox(height: 20),

            Obx(() => DropdownButtonFormField<String>(
              decoration: _inputDecoration("Relationship to User"),
              value: controller.relationship.value.isEmpty ? null : controller.relationship.value,
              items: ["Parent", "Guardian", "Relative"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (val) => controller.relationship.value = val ?? '',
            )),
            const SizedBox(height: 20),

            _buildInputField("About your GP", controller.gpController,
                hint: "Do you want to tell us about your GP?"),
            const SizedBox(height: 20),

            _buildInputField("Profile Tag (optional):", controller.tagController,
                hint: "ex. George - ADHD"),
            const SizedBox(height: 40),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF0C4956),
              ),
              onPressed: ()  {
                controller.submit();

              },
              child: const Text("Submit",style: textButton_white,),
            ),
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
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) => InputDecoration(
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
  );
}
