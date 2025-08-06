import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/widgets/assessment_report.dart';

import '../../../core/widgets/custom_appbar.dart';

class AssessmentHistoryDetails extends StatelessWidget {
  const AssessmentHistoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Assessment History'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assessment Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Assessment Info',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Child Autism Diagnosis',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '12/07/2025',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFFFE5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // Assessment Report
            const Text(
              'Assessment Report',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Report has been reviewed',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 30),
            // View report button
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4A55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                   Get.to(()=>AssessmentReport());
                   },
                child: const Text(
                  'View report',
                  style: textButton_white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Appointment Details
            const Text(
              'Appointment Details',
              style:TextStyle()
            ),
            const SizedBox(height: 16),
            buildDetailRow('Clinician Name', 'Sarah Mitchell'),
            buildDetailRow('Date & Time', '27/07/2025; 3:00PM EST'),
            buildDetailRow('Session Type', 'Video conference'),
            buildDetailRow('Session Status', 'Scheduled'),
            const SizedBox(height: 30),
            // Appointment details button
            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4A55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  // Handle Appointment details button click
                },
                child: const Text(
                  'Appointment details',
                  style: textButton_white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
