
// pages/assessment_detail_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import '../../primary_assessment/widgets/child_profile.dart';
import '../models/assessment_model.dart';
import 'patient_profile.dart';

class AssessmentDetailPage extends StatelessWidget {
  final AssessmentModel model;

  const AssessmentDetailPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Assessment'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              child: Image.asset('assets/images/carousul.png',),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4DC),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Text(model.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                infoTag(Icons.description, model.type),
                const SizedBox(width: 16),
                infoTag(Icons.access_time, "${model.totalTime}"),
              ],
            ),
            const SizedBox(height: 20),
             Text(model.description,style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D4C57),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                onPressed: () {
                  Get.to(()=>AssessmentPatientProfile(model: model,));
                },
                child: const Text("Start assessment", style: textButton_white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoTag(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(label,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
