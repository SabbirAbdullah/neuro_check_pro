import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_appbar.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'About NeuroCheck Pro'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'By using NeuroCheckPro, you agree to our terms of service. The app is intended to support self-assessment for neurodivergent traits like those associated with Autism or ADHD. It is not a medical diagnostic tool and should not be used as a replacement for professional evaluation. Users must be 13 years or older, or have guardian consent, to access and use the app.', style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            const Text(
              'You are responsible for the secure use of your account and data. Misuse of the app, including falsifying information or disruptive behavior, may result in access restrictions. NeuroCheckPro is not liable for any decisions made based on results without the involvement of a licensed healthcare professional. For support or inquiries, please email support@neurocheckpro.com.',
              style: TextStyle(fontSize: 15, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                // Optional: Add email launcher logic
              },
              child: const Text(
                'support@neurocheckpro.com',
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

          ],
        ),
      ),
    );
  }
}
