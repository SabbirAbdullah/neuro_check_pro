import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';

import '../../../../../core/values/app_colors.dart';
import '../../controllers/signup_controller.dart';

class SignupPhone extends StatelessWidget {
  final SignupController controller =
      Get.put(SignupController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sign Up',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Please confirm your country code and enter your phone number.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            IntlPhoneField(
              pickerDialogStyle: PickerDialogStyle(
              backgroundColor: Colors.white,
                  padding: EdgeInsets.all(20),
                  searchFieldCursorColor: AppColors.appBarColor,
                  searchFieldInputDecoration: InputDecoration(
                    hintText: 'Search Country',
                    border:  OutlineInputBorder(
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
                  countryNameStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500)),
              dropdownTextStyle:
              TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
              dropdownDecoration: BoxDecoration(),
              textAlign: TextAlign.justify,
              dropdownIcon: Icon(Icons.keyboard_arrow_down_outlined),
              cursorColor: AppColors.appBarColor,
              decoration: InputDecoration(
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
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              initialCountryCode: 'GB',
              onChanged: (phone) {
                controller.updatePhone(phone.number);
                controller.updateCountryCode(phone.countryCode);
              },
            ),
            const SizedBox(height: 30),
            Obx(() => controller.isLoading.value
                ? const Center(child: CustomLoading())
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0A4C5F),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: controller.sendOtp,
                    child: const Text('Send OTP', style: textButton_white),
                  )),
          ],
        ),
      ),
    );
  }
}
