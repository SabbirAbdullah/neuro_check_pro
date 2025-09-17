// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
// import '../../../data/repository/pref_repository.dart';
// import '../../assessment/controllers/assessment_controller.dart';
// import '../../assessment/models/assessment_model.dart';
// import '../../assessment/widgets/question_page.dart';
// import '../../billing_info/models/billing_info_model.dart' hide AssessmentModel;
// import '../controllers/diagnosis_controller.dart';
//
//
// class DiagnosisView extends StatelessWidget {
//   DiagnosisView ({super.key});
//   final DiagnosisController controller = Get.put(DiagnosisController());
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Your Child'),
//       body: Obx(() => ListView.builder(
//         itemCount: controller.assessments.length,
//         padding: const EdgeInsets.all(16),
//         itemBuilder: (context, index) {
//           final item = controller.assessments[index];
//           final isCompleted = item.status == 'Completed';
//
//           return Container(
//             margin: const EdgeInsets.only(bottom: 16),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.grey.shade300),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(item.name,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 22)),
//                           const SizedBox(height: 4),
//                           Text(item.assessment,
//                               style: TextStyle(
//                                   color: Colors.grey.shade600,
//                                   fontSize: 13)),
//                         ],
//                       ),
//                     ),
//                     Column(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 6),
//                           decoration: BoxDecoration(
//                             color: isCompleted
//                                 ? Colors.green.shade100
//                                 : Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: Text(
//                             item.status,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w400,fontSize: 12
//                             ),
//                           ),
//                         ),
//                         Text(item.date,
//                             style: TextStyle(
//                               fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey.shade700)),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//
//                 if (!isCompleted) ...[
//                   const SizedBox(height: 12),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: LinearProgressIndicator(
//                       minHeight: 12,
//                       value: item.progress,
//                       backgroundColor: Colors.grey.shade300,
//                       color: const Color(0xFF104E59),
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Center(
//                     child: Text(
//                       "${item.remainingQuestions} questions left out of ${item.totalQuestions}",
//                       style: TextStyle(
//                           color: Colors.grey.shade700, fontSize: 13),
//                     ),
//                   )
//                 ]
//               ],
//             ),
//           );
//         },
//       )),
//     );
//   }
// }
//
//
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';

import '../../../data/repository/pref_repository.dart';
import '../../assessment/controllers/assessment_controller.dart';
import '../../assessment/models/assessment_model.dart';
import '../../assessment/widgets/question_page.dart';


class ResumePage extends StatelessWidget {
  final AssessmentController controller = Get.put(AssessmentController());

  ResumePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Resume Diagnosis"),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.getAllDrafts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CustomLoading());
          }

          final drafts = snapshot.data!;
          if (drafts.isEmpty) {
            return const Center(child: Text("No drafts available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: drafts.length,
            itemBuilder: (context, index) {
              final draft = drafts[index];
              final patientId = draft["patientId"];
              final assessmentId = draft["assessmentId"];
              final assessmentName = draft["assessmentName"] ?? "Unknown";
              final patientName = draft["patientName"] ?? "Unknown";
              final totalQuestions = draft["questionLength"] ?? 0;
              final currentIndex = draft["currentIndex"] ?? 0;

              final progress = totalQuestions > 0
                  ? (currentIndex + 1) / totalQuestions
                  : 0.0;
              final isCompleted = currentIndex + 1 >= totalQuestions;

              return GestureDetector(
                onTap: ()async{

                  await controller.loadQuestions(assessmentId, patientId);

                  // 2️⃣ Restore draft answers
                  await controller.restoreDraft(assessmentId, patientId );

                  final assessment = controller.assessments.firstWhere(
                        (a) => a.id == assessmentId,
                    orElse: () => AssessmentModel(
                      id: assessmentId,
                      name: assessmentName,
                      description: "",
                      createdAt: "",
                      type: "",
                    ),
                  );

                  Get.to(() => QuestionPage(
                    model: assessment,
                    patientId: patientId,
                  ));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Text(
                                  "$patientName",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600, fontSize: 20),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  assessmentName,
                                  style: TextStyle(
                                      color: Colors.grey.shade600, fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          // Status badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? Colors.green.shade100
                                  : Colors.orange.shade100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              isCompleted ? "Completed" : "In Progress",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Delete button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              Get.back();
                              Get.snackbar("Delete", "resume diagnosis draft is deleted");
                              await controller.clearDraft(assessmentId ,patientId);
                              (context as Element).reassemble(); // refresh
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          minHeight: 12,
                          value: progress,
                          backgroundColor: Colors.grey.shade300,
                          color: const Color(0xFF104E59),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Center(
                        child: Text(
                          "${currentIndex + 1} of $totalQuestions answered",
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Resume button
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



