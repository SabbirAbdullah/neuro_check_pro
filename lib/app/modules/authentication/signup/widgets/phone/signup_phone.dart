import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';

import '../../../../../core/values/app_colors.dart';
import '../../controllers/signup_controller.dart';

class SignupPhone extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sign Up', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              'Please confirm your country code and enter your phone number.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
           //  DropdownButtonFormField<String>(
           //    dropdownColor: Colors.white,
           //    decoration:  InputDecoration(
           //      focusedBorder: OutlineInputBorder(
           //        borderRadius: BorderRadius.circular(30),
           //        borderSide: const BorderSide(color: AppColors.appBarColor)),
           //      enabledBorder: OutlineInputBorder(
           //          borderRadius: BorderRadius.circular(30),
           //          borderSide: const BorderSide(color: AppColors.borderColor)),),
           //    value: controller.selectedCountryCode.value,
           //    items: [
           //      DropdownMenuItem(child: Text('🇬🇧 United Kingdom'), value: '+44'),
           //      DropdownMenuItem(child: Text('🇧🇩 Bangladesh'), value: '+880'),
           //    ],
           //    onChanged: (val) {
           //      controller.selectedCountryCode.value = val!;
           //    },
           //  ),
           //  const SizedBox(height: 10),
           // TextField(
           //
           //          controller: controller.phoneController,
           //          keyboardType: TextInputType.phone,
           //          decoration:  InputDecoration(
           //
           //            focusedBorder: OutlineInputBorder(
           //                borderRadius: BorderRadius.circular(30),
           //                borderSide: const BorderSide(color: AppColors.appBarColor)),
           //            enabledBorder: OutlineInputBorder(
           //                borderRadius: BorderRadius.circular(30),
           //                borderSide: const BorderSide(color: AppColors.borderColor)),
           //            hintText: '7123 456789',
           //          ),
           //        ),

            IntlPhoneField(
              dropdownIcon: Icon(Icons.keyboard_arrow_down_outlined),
              cursorColor: AppColors.appBarColor,

              decoration: InputDecoration(
                labelText: '',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.borderColor)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: AppColors.borderColor)
                  ),

                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              initialCountryCode: 'GB',
              onChanged: (phone) {
                controller.updatePhone(phone.number);
                controller.updateCountryCode(phone.countryCode);
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A4C5F),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: controller.sendOtp,
              child: const Text('Send OTP',style: textButton_white,),
            )
          ],
        ),
      ),
    );
  }
}
