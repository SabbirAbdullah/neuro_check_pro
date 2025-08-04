import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/signup_controller.dart';

class SignupEmail extends StatelessWidget {
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
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              value: controller.selectedCountryCode.value,
              items: [
                DropdownMenuItem(child: Text('🇬🇧 United Kingdom'), value: '+44'),
                DropdownMenuItem(child: Text('🇧🇩 Bangladesh'), value: '+880'),
              ],
              onChanged: (val) {
                controller.selectedCountryCode.value = val!;
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '7123 456789',
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0A4C5F),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: controller.sendOtp,
              child: const Text('Send OTP'),
            )
          ],
        ),
      ),
    );
  }
}
