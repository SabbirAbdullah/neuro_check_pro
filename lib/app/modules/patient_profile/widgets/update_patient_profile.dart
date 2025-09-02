import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading.dart';
import '../controllers/patient_profile_controller.dart';
import '../models/patient_profile_model.dart';

class EditPatientDialog extends StatelessWidget {
  final PatientModel patient;
  final PatientProfileController controller = Get.put(PatientProfileController());

  EditPatientDialog({super.key, required this.patient}) {
    // Pre-fill controllers with existing patient data
    controller.nameController.text = patient.name;
    controller.dobController.text = patient.dateOfBirth.split('T').first;
    controller.gender.value = patient.gender;
    controller.relationship.value = patient.relationshipToUser;
    controller.gpController.text = patient.aboutGp ?? '';
    controller.tagController.text = patient.profileTag ?? '';

    controller.nameController.text = patient.name;
    controller.dobController.text = patient.dateOfBirth.split('T').first;

    // Normalize gender
    final genderMap = {
      "male": "Male",
      "female": "Female",
      "other": "Other",
    };
    controller.gender.value = genderMap[patient.gender.toLowerCase()] ?? "Other";

    // Normalize relationship
    final relationshipOptions = ["Parent", "Guardian", "Relative"];
    if (relationshipOptions.contains(patient.relationshipToUser)) {
      controller.relationship.value = patient.relationshipToUser;
    } else {
      controller.relationship.value = "Parent"; // default fallback
    }

    controller.gpController.text = patient.aboutGp ?? '';
    controller.tagController.text = patient.profileTag ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Edit Patient Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
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
              const Text('Gender', style: TextStyle(fontSize: 14, color: Colors.grey)),
              Obx(() {
                return CustomDropdown<String>(
                  items: ["Male", "Female", "Other"],
                  initialItem: controller.gender.value,
                  onChanged: (val) => controller.gender.value = val!,
                );
              }),
              const SizedBox(height: 20),
              const Text('Relationship to User',
                  style: TextStyle(fontSize: 14, color: Colors.grey)),
              Obx(() {
                return CustomDropdown<String>(
                  items: ["Parent", "Guardian", "Relative"],
                  initialItem: controller.relationship.value,
                  onChanged: (val) => controller.relationship.value = val ?? '',
                );
              }),
              const SizedBox(height: 20),
              _buildInputField("About your GP", controller.gpController),
              const SizedBox(height: 20),
              _buildInputField("Profile Tag (optional)", controller.tagController),
              const SizedBox(height: 30),
              Obx(() {
                return controller.isLoading.value
                    ? Center(child: CustomLoading())
                    : CustomButton(
                  text: "Save Changes",
                  onPressed: () async {
                    final Map<String, dynamic> updatedData = {};
                    if (controller.nameController.text.isNotEmpty) updatedData['name'] = controller.nameController.text;
                    if (controller.dobController.text.isNotEmpty) updatedData['dateOfBirth'] = controller.dobController.text;
                    if (controller.gender.value.isNotEmpty) updatedData['gender'] = controller.gender.value;
                    if (controller.relationship.value.isNotEmpty) updatedData['relationshipToUser'] = controller.relationship.value;
                    if (controller.gpController.text.isNotEmpty) updatedData['aboutGp'] = controller.gpController.text;
                    if (controller.tagController.text.isNotEmpty) updatedData['profileTag'] = controller.tagController.text;

                    controller.updatePatient(patient.id, updatedData);
                    Get.back();
                  },
                );
              }),
            ],
          ),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
