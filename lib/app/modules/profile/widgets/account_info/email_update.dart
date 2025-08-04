import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

import '../../controllers/profile_controller.dart';

class EmailUpdate extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  TextEditingController emailController = TextEditingController();

  EmailUpdate({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(title: 'Account information'),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "Email",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "You’ll use this email to receive updates, login and\nrecover your account",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 28),

              /// Email Text Field
              const Text("Email", style: TextStyle(fontSize: 14)),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: '',
                  filled: true,
                  fillColor: Colors.white,

                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  border: OutlineInputBorder(

                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "A verification will be sent to this email",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const Spacer(),

              /// Update Email Button
              SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C4A5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Add validation / API call
                      Get.snackbar("Updated",
                          "A verification has been sent to your email");
                    },
                    child: const Text(
                      "Update Email",
                      style: textButton_white,
                    ),
                  ))
            ])));
  }
}
