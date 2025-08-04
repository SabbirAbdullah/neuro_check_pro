
// pages/assessment_detail_page.dart
import 'package:flutter/material.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import '../models/assessment_model.dart';

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
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4DC),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            const SizedBox(height: 20),
            Text(model.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoTag(Icons.description, model.questionCount),
                const SizedBox(width: 16),
                _infoTag(Icons.access_time, model.duration),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "This comprehensive assessment is designed to evaluate Attention-Deficit/Hyperactivity Disorder (ADHD) symptoms in children. Through a series of structured questions and behavioral observations, it helps identify patterns related to inattention, hyperactivity, and impulsivity.\n\nThe assessment is carefully developed based on clinical guidelines and is reviewed by expert professionals in child psychology and neurodevelopment. Upon completion, you\u2019ll receive a detailed report highlighting your child\u2019s strengths, challenges, and whether further clinical evaluation or support may be recommended. This tool aims to provide clarity and early insights to support your child\u2019s development and well-being.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
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
                onPressed: () {},
                child: const Text("Start assessment", style: textButton_white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoTag(IconData icon, String label) {
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
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
