import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

import '../controllers/privacy_security_controller.dart';


class PrivacySecurityView extends StatelessWidget {
  PrivacySecurityView({super.key});

  final PrivacySecurityController controller =
  Get.put(PrivacySecurityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(title: 'Privacy and Security'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  Get.dialog(changePasswordDialog(controller));
                },
                child: infoTile('Change Password')),

            GestureDetector(
                onTap: _showDeleteAccountDialog,
                child: infoTile('Delete My Account'))
          ],
        ),
      ),
    );
  }

  Widget infoTile(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget changePasswordDialog(PrivacySecurityController controller) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
                "Current Password", controller.currentPasswordController),
            const SizedBox(height: 14),
            _buildTextField("New Password", controller.newPasswordController),
            const SizedBox(height: 14),
            _buildTextField(
                "Confirm Password", controller.confirmPasswordController),
            const SizedBox(height: 20),
           Container(
             width: double.infinity,
             child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF074A64),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  ),
                  onPressed: () => controller.changePassword(),
                  child: const Text(
                    "Save",
                    style: textButton_white
                  ),
                ),
           ),

          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController textController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          cursorColor: AppColors.appBarColor,
          controller: textController,
          obscureText: true,
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteAccountDialog() {
    showCupertinoDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            "Are you sure you want to permanently delete your account and all related data?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                // Handle delete logic
                Get.back(); // Close dialog
                Get.snackbar("Deleted", "Your account has been deleted",
                    snackPosition: SnackPosition.BOTTOM);
              },
              child: Text(
                "Delete",
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Get.back(); // Close dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

}
