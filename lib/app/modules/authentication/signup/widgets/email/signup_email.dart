import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';

import '../../../../../core/widgets/custom_loading.dart';
import '../../controllers/signup_controller.dart';

class SignUpEmail extends StatelessWidget {
  final SignupController controller = Get.put(SignupController(), permanent: true);


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
              'Please enter your valid email address here for the signup process.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            TextField(
              cursorColor: AppColors.appBarColor,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(CupertinoIcons.mail),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: AppColors.appBarColor),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Obx(() => controller.isLoading.value
                ?  Center(child: CustomLoading())
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A4C5F),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
