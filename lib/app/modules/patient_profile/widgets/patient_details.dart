
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/modules/patient_profile/widgets/update_patient_profile.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading.dart';
import '../controllers/patient_profile_controller.dart';
import '../models/patient_profile_model.dart';

import 'package:get/get.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ChildDetailPage extends StatelessWidget {
  final PatientModel child;
  const ChildDetailPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Rx<File?> pickedImage = Rx<File?>(null);

    void _showEditOptions() {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: const Text('Profile Picture'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                Navigator.pop(context);
                final ImagePicker picker = ImagePicker();
                final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  pickedImage.value = File(image.path);
                  // TODO: upload to server here
                }
              },
              child: const Text('Upload Image'),
            ),
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                pickedImage.value = null;
                // TODO: call API to delete image from server
              },
              child: const Text('Delete Image'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(title: 'Patient Profile'),
        body: Column(
          children: [
            const SizedBox(height: 16),
            // Profile avatar with edit icon
            Center(
              child: Stack(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.blueAccent.shade100,
                      backgroundImage: pickedImage.value != null
                          ? FileImage(pickedImage.value!)
                          : (child.imageUrl != null
                          ? NetworkImage(child.imageUrl!) as ImageProvider
                          : null),
                      child: (pickedImage.value == null && child.imageUrl == null)
                          ? Text(child.initials('child'),
                          style: const TextStyle(fontSize: 28, color: Colors.white))
                          : null,
                    );
                  }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: _showEditOptions,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: const Icon(Icons.edit, size: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(child.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),

            const SizedBox(height: 12),
             TabBar(

                indicatorColor: AppColors.appBarColor,
                labelColor: AppColors.appBarColor,
                dividerHeight: 1,dividerColor: AppColors.dividerColor,
                unselectedLabelColor: Colors.black54,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'Basic Info'),
                  Tab(text: 'Assessment History')
                ],
              ),
            
            // Tab content
            Expanded(
              child: TabBarView(
                children: [
                  // Basic Info Tab
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text("Edit Patient Profile",style: textButton_blue,),
                          IconButton(onPressed: (){
                            showEditPatientDialog( child);
                          }, icon: Icon(Icons.edit)),
                        ],),
                        InfoRow(label: 'Name', value: child.name),
                        const SizedBox(height: 10),
                        InfoRow(
                          label: 'Age',
                          value: '${calculateAge (child.dateOfBirth)} years',
                        ),

                        const SizedBox(height: 10),
                        InfoRow(
                          label: 'Date Of Birth',
                          value: child.dateOfBirth == null
                              ? 'Not set'
                              : '${child.dateOfBirth.split('T').first}',
                        ),
                        const SizedBox(height: 20),
                        const Text('Notes', style: TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        const Text(
                          'No notes yet. Use this area to write therapy notes, assessments or observations.',
                        ),
                      ],
                    ),
                  ),
                  // Assessment History Tab
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Icon(CupertinoIcons.calendar_badge_plus,
                            size: 64, color: Colors.blueGrey[200]),
                        const SizedBox(height: 12),
                        const Text('No appointments yet',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        const Text('Schedule therapy sessions and follow-ups here.'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showEditPatientDialog(PatientModel patient) {
    final PatientProfileController controller = Get.put(PatientProfileController());

    // Pre-fill controllers
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
      controller.relationship.value = "Parent";
    }

    controller.gpController.text = patient.aboutGp ?? '';
    controller.tagController.text = patient.profileTag ?? '';

    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
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
                  onTap: () => controller.showCupertinoDatePicker(Get.context!),
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
                      ? const Center(child: CustomLoading())
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

                      await controller.updatePatient(patient.id, updatedData);
                      Get.back(); // close dialog
                    },
                  );
                }),
              ],
            ),
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

  int calculateAge(String dob) {
    final birthDate = DateTime.parse(dob);
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(value, textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
