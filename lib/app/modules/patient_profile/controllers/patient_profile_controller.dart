import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/values/app_colors.dart';
import '../../../data/repository/patient_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../../data/repository/profile_repository.dart';
import '../models/patient_form_model.dart';
import '../models/patient_profile_model.dart';

// -------------------- Controller --------------------
class PatientProfileController extends GetxController {
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final gender = ''.obs;
  final relationship = ''.obs;
  final gpController = TextEditingController();
  final tagController = TextEditingController();

  var isLoading = false.obs;
  final PatientRepository _repository =
      Get.find(tag: (PatientRepository).toString());
  final PrefRepository _prefRepository =
      Get.find(tag: (PrefRepository).toString());
  final ProfileRepository profileRepository =
  Get.find(tag: (ProfileRepository).toString());
  Future<void> submitNewChild() async {
    final id = await _prefRepository.getInt("id");
    final token = await _prefRepository.getString("token");

    try {
      isLoading.value = true;

      final patient = PatientRequestModel(
        name: nameController.text.trim(),
        dateOfBirth: dobController.text.trim(),
        gender: gender.value,
        relationshipToUser: relationship.value,
        aboutGp: gpController.text.trim(),
        profileTag: tagController.text.trim(),
        userId: id,
      );

      final response = await _repository.addPatient(patient, token);

      if (response.statusCode == 201) {
        fetchPatients();
        Get.back();
        // ✅ Success snackbar
        Get.snackbar(
          "Success",
          response.message);

        // ✅ Clear form fields
        nameController.clear();
        dobController.clear();
        gpController.clear();
        tagController.clear();
        gender.value = "";
        relationship.value = "";


      } else {
        Get.snackbar("Error", response.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePatient(int id, Map<String, dynamic> updatedData) async {
    final token = await _prefRepository.getString('token');
    try {
      isLoading.value = true;
      final updatedPatient = await _repository.updatePatient(id, updatedData, token);
      Get.back();
      // patients.value = updatedPatient;
      Get.snackbar("Success", "Patient updated successfully");
      fetchPatients();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void showCupertinoDatePicker(BuildContext context) {
    final now = DateTime.now();
    DateTime selected = now;

    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
        height: 300,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  child: Text('Cancel'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                CupertinoButton(
                  child: Text('Done'),
                  onPressed: () {
                    dobController.text =
                        "${selected.year}-${selected.month.toString().padLeft(2, '0')}-${selected.day.toString().padLeft(2, '0')}";
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: now.subtract(Duration(days: 365 * 5)),
                maximumDate: now,
                onDateTimeChanged: (date) {
                  selected = date;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  var patients = <PatientModel>[].obs;
  Future<void> fetchPatients() async {
    try {
      isLoading.value = true;
      final token = await _prefRepository.getString('token');
      final id = await _prefRepository.getInt('id');
      final data = await _repository.fetchPatients(id, token);
      patients.value = data;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  var selectedImage = Rx<File?>(null);

  /// Open image picker and upload
  Future<void> pickAndUploadImage(int id) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? croppedImage = await _cropImage(File(pickedFile.path));

      if (croppedImage != null) {
        // Update the Rx value
        selectedImage.value = File(croppedImage.path);

        // Upload the actual File (unwrap from Rx)
        final fileToUpload = selectedImage.value;
        if (fileToUpload != null) {
          await uploadImage(fileToUpload, id);
        }
      }}
  }

  Future<File?> _cropImage(File imageFile) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      // cropStyle: CropStyle.rectangle, // Change to CropStyle.circle if needed
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.appBarColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original, // Set the initial aspect ratio
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0), // Set the desired aspect ratio
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }


  /// Upload image file, then update user info
  Future<void> uploadImage( File file, int id) async {
    final token = await _prefRepository.getString('token');
    try {
      isLoading.value = true;

      // 1. Upload file
      final response = await profileRepository.uploadFile( token, file);
      // 2. Get uploaded filename
      final String uploadedFileName = response.payload.filename;

      // 3. Update user info with filename
      final Map<String, dynamic> data = {
        "image": uploadedFileName,
      };
      await updatePatient(id, data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPatients();
  }


  ///////////////////////////////////////////
  final children = <PatientProfileModel>[].obs;

  void addChild(PatientProfileModel c) => children.add(c);

  void updateChild(PatientProfileModel updated) {
    final idx = children.indexWhere((c) => c.id == updated.id);
    if (idx != -1) children[idx] = updated;
  }

  void removeChild(String id) => children.removeWhere((c) => c.id == id);
}
