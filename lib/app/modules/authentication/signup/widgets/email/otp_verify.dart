

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/values/app_colors.dart';
import '../../../../../core/values/text_styles.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../controllers/signup_controller.dart';

class OtpEmail extends StatelessWidget {
  final SignupController controller = Get.find<SignupController>();

  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> textControllers = List.generate(4, (_) => TextEditingController());

  OtpEmail({super.key});

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < focusNodes.length - 1) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    } else {
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
    // Always update OTP code after the text change
    controller.otpCode.value =
        textControllers.map((c) => c.text).join().trim();
  }

  @override
  Widget build(BuildContext context) {
    final id = Get.arguments; // passed from Send OTP page
    controller.identifier.value = id;

    return Scaffold(
      appBar: AppBar(title: const Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Verification', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'An OTP has been sent to $id. Enter OTP here for verification.',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    cursorColor: AppColors.appBarColor,
                    controller: textControllers[index],
                    focusNode: focusNodes[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    onChanged: (value) => _onOtpChanged(index, value),
                    decoration: InputDecoration(
                      counterText: '',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.appBarColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.borderColor)),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text("Didn't get OTP?"),
                TextButton(
                  onPressed: controller.sendOtp,
                  child: const Text('Resend OTP', style: textButtonColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? Center(child: CustomLoading())
                : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A4C5F),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: controller.verifyOtp,
              child: const Text('Verify', style: textButton_white),
            )),
          ],
        ),
      ),
    );
  }
}
