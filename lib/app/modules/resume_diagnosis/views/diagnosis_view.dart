import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import '../controllers/diagnosis_controller.dart';


class DiagnosisView extends StatelessWidget {
  DiagnosisView ({super.key});
  final DiagnosisController controller = Get.put(DiagnosisController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Your Child'),
      body: Obx(() => ListView.builder(
        itemCount: controller.assessments.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = controller.assessments[index];
          final isCompleted = item.status == 'Completed';

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22)),
                          const SizedBox(height: 4),
                          Text(item.assessment,
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13)),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? Colors.green.shade100
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.status,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,fontSize: 12
                            ),
                          ),
                        ),
                        Text(item.date,
                            style: TextStyle(
                              fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade700)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (!isCompleted) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      minHeight: 12,
                      value: item.progress,
                      backgroundColor: Colors.grey.shade300,
                      color: const Color(0xFF104E59),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Center(
                    child: Text(
                      "${item.remainingQuestions} questions left out of ${item.totalQuestions}",
                      style: TextStyle(
                          color: Colors.grey.shade700, fontSize: 13),
                    ),
                  )
                ]
              ],
            ),
          );
        },
      )),
    );
  }
}
