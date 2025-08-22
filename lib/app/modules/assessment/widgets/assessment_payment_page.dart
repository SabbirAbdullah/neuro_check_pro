import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/modules/assessment/widgets/question_page.dart';

import '../../patient_profile/models/patient_profile_model.dart';
import '../../primary_assessment/views/primary_assessment.dart';
import '../controllers/assessment_controller.dart';
import '../models/assessment_model.dart';


class AssessmentPaymentPage extends StatelessWidget {
 final PatientModel child;
 final AssessmentModel model;

  const AssessmentPaymentPage({super.key, required this.child, required this.model});
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(title: 'Access to Full Assessment'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Full Assessment Access", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text(
              "Access your complete assessment and get personalised insights from licensed clinicians.",
              style: TextStyle(color: Colors.grey,fontSize: 12),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircleAvatar(
                    radius: 40,
                    child: child.imageUrl == null
                        ?Text(child.initials('child'), style:  TextStyle(fontSize: 18, color: Colors.white))
                        :Image.network(child.imageUrl!)

                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(child.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    Text("${child.dateOfBirth} Years", style: const TextStyle(color: Colors.grey,fontSize: 12)),
                  ],
                )
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("Child ADHD Diagnosis", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text("£39.99", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 8),
            const Text("One-time purchase", style: TextStyle(color: Colors.grey,fontSize: 12)),
            const SizedBox(height: 24),
            const Text("Benefits", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            benefitItem("Detailed report reviewed by licensed clinicians"),
            benefitItem("Follow-up video consultation"),
            benefitItem("Priority case handling"),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.info_outline, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "Your payment is securely processed by Stripe. We do not store your card details.",
                      style: TextStyle(color: Colors.grey,fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4A55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: ()async {
                  await Get.snackbar("Payment", "Proceeding to Stripe...");
                  Get.to(()=> QuestionPage(model: model,));
                },
                child: const Text("Proceed to Payment", style: textButton_white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget benefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children:  [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 8),
          Expanded(child: Text(text, style: TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}
