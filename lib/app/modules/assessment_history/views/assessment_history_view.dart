import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/controllers/assessment_history_controller.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/widgets/assessment_history_details.dart';
import 'package:intl/intl.dart';

class AssessmentHistoryView extends StatelessWidget {
  AssessmentHistoryView({super.key});
final AssessmentHistoryController controller = Get.put(AssessmentHistoryController());
@override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(title: 'Assessment History'),

      body:  Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CustomLoading());
        }

        if (controller.submissions.isEmpty) {
          return Center(child: Text("No submissions found"));
        }

        return ListView.builder(

          itemCount: controller.submissions.length,

          itemBuilder: (context, index) {
            final submission = controller.submissions[index];
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F1FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title + Status Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                             "${submission.assessment.name}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color:  Color(0xff32B355),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                                "${(submission.status == null || submission.status!.isEmpty) ? 'pending' : submission.status}",
                                style: TextStyle(
                                  color: submission.status =='' && submission.status =='Pending'
                                      ? Colors.black  : Colors.white,
                                  fontWeight: FontWeight.w400,fontSize: 11
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      // Date and Time
                      Row(
                        children: [
                          const Text(
                            'Date and Time',
                            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400,fontSize: 12),
                          ),
                          const SizedBox(width: 8),

                        ],
                      ),
                      const SizedBox(height: 20),
                      // View Details Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey.shade300,),
                              SizedBox(width: 6,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(submission.patient.name),
                                  Text(
                                    DateFormat("d MMMM, yyyy").format(submission.createdAt),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  )

                                ],
                              )



                            ],
                          ),
                          SizedBox(
                            child: TextButton(

                              onPressed: () {
                                // Handle button action
                                Get.to(()=>AssessmentHistoryDetails(data: submission,));
                                // Get.snackbar("On Progress" ," In next Update" );
                              },
                              child: Text("View details",style: textButton,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            );
          },
        );
      }),
      // body: ListView.separated(
      //   padding: const EdgeInsets.all(16),
      //   itemCount: controller.assessments.length,
      //   separatorBuilder: (_, __) => const SizedBox(height: 20),
      //   itemBuilder: (context, index) {
      //     final item = controller.assessments[index];
      //     return
      //   },
      // ),
    );
  }
}
