import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/modules/patient_profile/models/patient_profile_model.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../../core/widgets/expended_text.dart';
import '../../../data/model/answer_submission_model.dart';
import '../../assessment/models/assessment_model.dart';
import '../../assessment/views/assessment_view.dart';
import '../../bottom_navigation/views/bottom_navigation_view.dart';
import '../../onboardings/controllers/onboarding_controller.dart';
import '../controllers/primary_assessment_controller.dart';
import '../widgets/quiz_results.dart';

class InitialAssessmentQuestion extends StatelessWidget {
  final int patient;
  final int assessmentId;
  final PrimaryAssessmentController controller = Get.put(PrimaryAssessmentController());

  InitialAssessmentQuestion({
    super.key,
    required this.patient,
    required this.assessmentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: controller.goToPreviousQuestion,
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoading());
        }

        if (controller.questions.isEmpty) {
          return const Center(child: Text("No questions found"));
        }

        final question = controller.questions[controller.currentIndex.value];
        final selected = controller.answers[question.id] ?? "";

        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: (controller.currentIndex.value + 1) /
                    controller.questions.length,
                backgroundColor: Colors.grey.shade200,
                color: const Color(0xFF0D4D54),
              ),
              const SizedBox(height: 8),
              Text(
                "${controller.currentIndex.value + 1} / ${controller.questions.length}",
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 32),

              // Question text
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  question.questions,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Answer options
              if (question.answerType == "Yes/No")
                ...["Yes", "No"].map(
                      (option) => _buildOption(option, selected, controller),
                )
              else if (question.answerType == "MultipleChoice")
                ...question.options!.map(
                      (option) => _buildOption(option, selected, controller),
                )
              else if (question.answerType == "Text")
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GetBuilder<PrimaryAssessmentController>(
                      id: "textField_${question.id}",
                      builder: (_) {
                        final textController = TextEditingController(
                          text: controller.answers[question.id] ?? "",
                        );
                        textController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController.text.length),
                        );

                        return TextField(
                          controller: textController,
                          cursorColor: AppColors.appBarColor,
                          maxLines: 5,
                          onChanged: controller.selectAnswer,
                          decoration: InputDecoration(
                            hintText: "Write your answer here...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: AppColors.borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: AppColors.borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                              BorderSide(color: AppColors.borderColor),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

              const Spacer(),

              // Navigation buttons
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (controller.currentIndex.value > 0)
                      ElevatedButton(
                        onPressed: controller.goToPreviousQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("Previous"),
                      )
                    else
                      const SizedBox(),
                    ElevatedButton(
                      onPressed: controller.answers[question.id] == null
                          ? null
                          : () =>
                          controller.goToNextQuestion(patient, assessmentId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D4D54),
                        foregroundColor: Colors.white,
                      ),
                      child: Text(
                        controller.currentIndex.value + 1 <
                            controller.questions.length
                            ? "Next"
                            : "Finish",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildOption(String option, dynamic selected,
      PrimaryAssessmentController controller) {
    final isSelected = selected == option;
    return GestureDetector(
      onTap: () => controller.selectAnswer(option),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0D4D54).withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF0D4D54) : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            option,
            style: TextStyle(
              fontSize: 16,
              color: isSelected ? const Color(0xFF0D4D54) : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}

class InitialQuestionSummary extends StatelessWidget {
  final PrimaryAssessmentController controller;
  final int  patientId;
  final int assessmentId;
  const InitialQuestionSummary({super.key, required this.controller,  required this.patientId, required  this.assessmentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Summary'),
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
              return  CustomButton(text: "Submit All", onPressed:  () async {

                    await controller.submitAllAnswers(patientId);
              },);
            })


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
