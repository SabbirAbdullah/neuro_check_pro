import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Privacy policy'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'At NeuroCheckPro, we are committed to protecting your privacy. When you use our app, we may collect personal information such as your name, age, and responses to assessment questions. This data helps us deliver personalized insights, track your progress, and improve overall app performance. We also collect anonymous device and usage information to ensure a smooth and reliable experience.',
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'We do not sell or share your personal data with third parties, except when legally required or with your explicit permission—such as when you choose to share results with a healthcare provider. Your data is stored securely using encryption and industry-standard protections. By using NeuroCheckPro, you agree to our data practices. If you have any questions, please contact us at',
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                // Optional: Add email launcher logic
              },
              child: const Text(
                'privacy@neurocheckpro.com',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Duplicated text blocks (as per the image)
            const Text(
              'We do not sell or share your personal data with third parties, except when legally required or with your explicit permission—such as when you choose to share results with a healthcare provider. Your data is stored securely using encryption and industry-standard protections. By using NeuroCheckPro, you agree to our data practices. If you have any questions, please contact us at',
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'We do not sell or share your personal data with third parties, except when legally required or with your explicit permission—such as when you choose to share results with a healthcare provider. Your data is stored securely using encryption and industry-standard protections. By using NeuroCheckPro, you agree to our data practices. If you have any questions, please contact us at',
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
