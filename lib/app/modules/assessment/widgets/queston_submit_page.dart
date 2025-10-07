
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/values/app_colors.dart';
import '../../../core/widgets/custom_appbar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../../core/widgets/expended_text.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../bottom_navigation/views/bottom_navigation_view.dart';
import '../../onboardings/controllers/onboarding_controller.dart';
import '../controllers/assessment_controller.dart';


class PaidQuestionSummary extends StatelessWidget {
  final AssessmentController controller;
  final int  patientId;
  final int assessmentId;
  const PaidQuestionSummary({super.key, required this.controller,  required this.patientId, required this.assessmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Summary"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
                  final q = controller.questions[index];
                  final ans = controller.answers[q.id] ?? "Not answered";
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(q.questions,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.circle, color: AppColors.appBarColor,size: 12,),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ExpandableText(formatAnswer(ans)), // ✅ always string
                            ),

                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Obx((){
              if (controller.isLoading.value) {
                return Center(child: CustomLoading());
              }
              return  CustomButton(text: "Submit All" , onPressed:  () async {

                await controller.submitAllAnswers(patientId, assessmentId);
              },);
            })

            // ElevatedButton(
            //   onPressed: () async {
            //     controller.submitAllAnswers(patientId:patient.id );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: const Color(0xFF0D4D54),
            //   ),
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(vertical: 12),
            //     child: Text("Submit All", style: TextStyle(color: Colors.white)),
            //   ),
            // )

          ],
        ),
      ),
    );
  }
  String formatAnswer(dynamic ans) {
    if (ans is List) {
      return ans.join(", "); // join list items with comma or space
    } else {
      return ans.toString(); // if already a string
    }
  }

}

class SubmitSuccessPage extends StatelessWidget {
  SubmitSuccessPage({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),
            const Text("Submission Successful!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            CupertinoButton.filled(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child:  Text("Go To Dashboard",style: TextStyle(color: Colors.black),),
              onPressed: () {

                Get.offAll(()=>BottomNavigationView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
