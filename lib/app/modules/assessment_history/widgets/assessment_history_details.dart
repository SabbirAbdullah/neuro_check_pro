import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/widgets/appointment_details.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/widgets/assessment_report.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/widgets/submitted_answer.dart';

import '../../../core/widgets/custom_appbar.dart';
import '../controllers/assessment_history_controller.dart';
import '../models/assessment_history_model.dart';

// class AssessmentHistoryDetails extends StatelessWidget {
//   const AssessmentHistoryDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Assessment History'),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Assessment Info
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Assessment Info',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Child Autism Diagnosis',
//                         style: TextStyle(
//                           fontSize: 14,fontWeight: FontWeight.w500,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         '12/07/2025',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFDFFFE5),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: const Text(
//                     'Completed',
//                     style: TextStyle(
//                       color: Colors.black,fontSize: 12,
//
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             // Assessment Report
//             const Text(
//               'Assessment Report',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Report has been reviewed',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 12,
//               ),
//             ),
//             const SizedBox(height: 30),
//             // View report button
//             SizedBox(
//               width: double.infinity,
//
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF0B4A55),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 onPressed: () {
//                    Get.to(()=>AssessmentReport());
//                    },
//                 child: const Text(
//                   'View report',
//                   style: textButton_white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 40),
//             // Appointment Details
//             const Text(
//               'Appointment Details',
//               style:TextStyle(fontSize: 18,fontWeight: FontWeight.w500)
//             ),
//             const SizedBox(height: 16),
//             buildDetailRow('Clinician Name', 'Sarah Mitchell'),
//             buildDetailRow('Date & Time', '27/07/2025; 3:00PM EST'),
//             buildDetailRow('Session Type', 'Video conference'),
//             buildDetailRow('Session Status', 'Scheduled'),
//             const SizedBox(height: 30),
//             // Appointment details button
//             SizedBox(
//               width: double.infinity,
//
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF0B4A55),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                 ),
//                 onPressed: () {
//                   Get.to(()=>AppointmentDetailsPage());
//                 },
//                 child: const Text(
//                   'Appointment details',
//                   style: textButton_white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildDetailRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: Row(
//         children: [
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Text(
//             value,
//             style: const TextStyle(
//               color: Colors.black54,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class AssessmentHistoryDetails extends StatelessWidget {

  AssessmentHistoryDetails({super.key, required this.data});
  final Submission data;

  final AssessmentHistoryController controller = Get.put(AssessmentHistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'Assessment History'),
      body:  SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.patient.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        data.assessment.name,
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        DateFormat("d MMMM, yyyy").format(data.createdAt),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                           controller.loadAnswers(data.assessmentId, data.patientId);
                          Get.to(()=> SubmittedAnswerPage());
                        },
                        child: Row(
                          children: [
                             Text(
                              "Submitted assessment",
                              style: TextStyle(color: AppColors.appBarColor, fontWeight: FontWeight.w500),
                            ),
                            Icon(Icons.arrow_outward_rounded,size: 20,color: AppColors.appBarColor,)
                          ],
                        ),
                      ),


                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Pending",
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Appointment
              const Text(
                "Appointment",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 20),
                              SizedBox(width: 6,),
                              Text("12 Nov 2025 • 8:00 PM - 8:30 PM", style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(radius: 20, backgroundColor: Colors.grey),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Max",
                                          style: const TextStyle(fontWeight: FontWeight.w500)),
                                      Text("FCPS",
                                          style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "Pending",
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) {
                        if (value == "reschedule") {
                          // TODO: implement rescheduling
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: "reschedule",
                          child: Text("Request for rescheduling"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Assessment Feedback
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Assessment feedback",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {}, // TODO: menu options
                  ),
                ],
              ),
              Text(
                data.summary,
                style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
              ),
            ],
          ),
        )

    );
  }
}
