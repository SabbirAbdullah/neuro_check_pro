import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

class AppointmentDetailsPage extends StatelessWidget {
  const AppointmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Appointment Details'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Appointment Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            _buildDetailRow("Clinician Name", "Sarah Mitchell"),
            const SizedBox(height: 12),
            _buildDetailRow("Date & Time", "27/07/2025; 3:00PM EST"),
            const SizedBox(height: 12),
            _buildDetailRow("Session Type", "Video conference"),
            const SizedBox(height: 12),
            _buildDetailRow("Session Status", "Scheduled"),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0B4A55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                onPressed: () {
                  Get.snackbar("Action", "Reschedule appointment clicked");
                },
                child: const Text(
                  "Reschedule appointment",
                  style:textButton_white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),

           ]
        ),
         Divider(height: 20, thickness:0.5,color: AppColors.dividerColor),

      ],
    );
  }
}
