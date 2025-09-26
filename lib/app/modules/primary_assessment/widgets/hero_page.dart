import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/modules/primary_assessment/controllers/primary_assessment_controller.dart';
import 'package:neuro_check_pro/app/modules/primary_assessment/views/primary_assessment.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../../assessment/widgets/patient_profile.dart';
import '../../patient_profile/controllers/patient_profile_controller.dart';
import 'child_profile.dart';

class HeroPage extends StatelessWidget {
   HeroPage({super.key});
  final PrimaryAssessmentController primaryAssessmentController = Get.put(PrimaryAssessmentController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(title: 'Self-Assessment'),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Center(
              child: Image.asset(
                'assets/images/brain.png',
                height: 160,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Let’s Begin Your Initial Check",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFF0D4D54),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              "This short assessment consist of 10 questions helps us understand any early signs of Autism or ADHD.\n\nYour answers will guide whether a full clinical review is recommended or not.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50,),
            Obx(() {
              return SizedBox(
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D4D54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: primaryAssessmentController.assessments.isNotEmpty
                      ? () {
                    Get.to(() => AssessmentChildSelectPage(
                      assessmentId: primaryAssessmentController.assessments[0].id,
                    ));
                  }
                      : null, // disable until loaded
                  child: const Text(
                    'Start assessment',
                    style: textButton_white,
                  ),
                ),
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
