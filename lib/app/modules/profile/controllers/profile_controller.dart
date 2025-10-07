import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:neuro_check_pro/app/data/repository/profile_repository.dart';
import 'package:neuro_check_pro/app/modules/welcome/controllers/splash_controller.dart';
import '../../../data/model/user_info_model.dart';
import '../../../data/repository/auth_repository.dart';
import '../../../data/repository/pref_repository.dart';
import '../../../core/values/app_colors.dart';


class ProfileController extends GetxController {


  final PrefRepository _prefRepository =
  Get.find(tag: (PrefRepository).toString());
  final ProfileRepository _repository =
  Get.find(tag: (ProfileRepository).toString());

  final AuthenticationRepository authenticationRepository =
  Get.find(tag: (AuthenticationRepository).toString());

  TextEditingController nameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();


  var isLoading = false.obs;
  var user = Rxn<UserInfoModel>();

  Future<void> updateUserInfo(Map<String, dynamic> data) async {
    final token = await _prefRepository.getString('token');
    final userId = await _prefRepository.getInt('id');
    isLoading.value = true;
    try {

      final updatedUser = await _repository.updateUser(userId, data, token);
      user.value = updatedUser;
      Get.back();

      Get.snackbar("Success", "Profile updated successfully");
      await fetchUserInfo();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<bool> fetchUserInfo() async {
    final token = await _prefRepository.getString('token');
    final id = await _prefRepository.getInt('id');
    if (token.isEmpty || id == null) return false;

    try {
      isLoading.value = true;
      final response = await authenticationRepository.getUserById(id, token);

      if (response.statusCode == 201) {
        user.value = response.payload;
        return true;
      } else {
        Get.snackbar("Error", response.message);
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _prefRepository.remove('token');
    await _prefRepository.remove('id');
    // Get.delete<OnboardingController>();
    // Navigate to onboarding or login screen
    Get.offAllNamed('/signin_view');
  }



  var selectedImage = Rx<File?>(null);

  /// Open image picker and upload
  Future<void> pickAndUploadImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? croppedImage = await _cropImage(File(pickedFile.path));

      if (croppedImage != null) {
        // Update the Rx value
        selectedImage.value = File(croppedImage.path);

        // Upload the actual File (unwrap from Rx)
        final fileToUpload = selectedImage.value;
        if (fileToUpload != null) {
          await uploadImage(fileToUpload);
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
Future<void> uploadImage( File file) async {
  final token = await _prefRepository.getString('token');
  try {
    isLoading.value = true;

    // 1. Upload file
    final response = await _repository.uploadFile( token, file);
    // 2. Get uploaded filename
    final String uploadedFileName = response.payload.filename;

    // 3. Update user info with filename
    final Map<String, dynamic> data = {
      "image": uploadedFileName,
    };
    await updateUserInfo(data);
  } catch (e) {
    Get.snackbar("Error", e.toString());
  } finally {
    isLoading.value = false;
  }
}
  //
  // Future<UploadResponseModel> uploadFile( File file) async {
  //   final token = await _prefRepository.getString('token');
  //   try {
  //     final fileName = file.path.split('/').last;
  //
  //     // Detect mime type safely
  //     final mimeType = lookupMimeType(file.path) ?? 'application/octet-stream';
  //     final mimeTypeParts = mimeType.split('/');
  //
  //     final formData = FormData.fromMap({
  //       'file': await MultipartFile.fromFile(
  //         file.path,
  //         filename: fileName,
  //         contentType: MediaType(mimeTypeParts[0], mimeTypeParts[1]),
  //       ),
  //     });
  //
  //     final response = await dio.post(
  //       'https://neurocheckpro.com/api/upload', // replace with full URL if needed
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': 'multipart/form-data',
  //         },
  //       ),
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       return UploadResponseModel.fromMap(response.data);
  //     } else {
  //       throw Exception(
  //         response.data['message'] ?? 'Failed to upload file',
  //       );
  //     }
  //   } on DioException catch (e) {
  //     if (e.response != null) {
  //       throw Exception(
  //         e.response!.data['message'] ?? 'Dio error: ${e.message}',
  //       );
  //     } else {
  //       throw Exception('Dio error: ${e.message}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }








  var uploadedImagePath = ''.obs; // server path
  var uploadedFile = Rx<File?>(null); // local picked file

  /// Picked file from gallery/camera will be stored here
  void setPickedFile(File file) {
    uploadedFile.value = file;
  }



/// Delete image
  void deleteImage() {
    selectedImage.value = null;
  }



}
