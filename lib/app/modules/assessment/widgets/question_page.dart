import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_button.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';

import '../../../core/values/app_colors.dart';

import '../../patient_profile/models/patient_profile_model.dart';
import '../controllers/assessment_controller.dart';
import '../models/assessment_model.dart';

class QuestionPage extends StatelessWidget {
  final AssessmentModel model;
  final  int patientId ;
  final AssessmentController controller = Get.put(AssessmentController());

  QuestionPage({
    super.key, required this.patientId, required this.model,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Colors.black),
          onPressed: ()=> controller.goToPreviousQuestion(model.id,patientId, model.name)
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Scaffold(
            body: Center(child: CustomLoading()),
          );
        }

        if (controller.questions.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No questions found")),
          );
        }

        final question = controller.questions[controller.currentIndex.value];
        final dynamic selected = controller.answers[question.id] ??
            (question.answerType == "MultipleChoice" ? <String>[] : "");


        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
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
                Text(
                    "${controller.currentIndex.value + 1} / ${controller.questions.length}",
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 32),
                const SizedBox(height: 20),

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

                // Answer options
                // Answer options
                if (question.answerType == "Yes/No") ...[
                  ...["Yes", "No"].map((option) {
                    final isSelected = selected == option;
                    return GestureDetector(
                      onTap: () => controller.selectAnswer(option,patientId, model.name),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0D4D54).withOpacity(0.05)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0D4D54)
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? const Color(0xFF0D4D54)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ] else if (question.answerType == "MultipleChoice") ...[
                  ...question.options!.map((option) {
                    final selectedList =
                        (selected is List<String>) ? selected : <String>[];
                    final isSelected = selectedList.contains(option);

                    return GestureDetector(
                      onTap: () => controller.selectAnswer(option,patientId, model.name),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF0D4D54).withOpacity(0.05)
                              : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0D4D54)
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              color: isSelected
                                  ? const Color(0xFF0D4D54)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ] else if (question.answerType == "Text") ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GetBuilder<AssessmentController>(
                      id: "textField_${question.id}", // unique id for rebuilds
                      builder: (_) {
                        final textController = TextEditingController(
                          text: controller.answers[question.id] ?? "",
                        );

                        // Keep cursor at the end
                        textController.selection = TextSelection.fromPosition(
                          TextPosition(offset: textController.text.length),
                        );

                        return TextField(
                          controller: textController,
                          cursorColor: AppColors.appBarColor,
                          maxLines: 5,
                          onChanged: (value) => controller.selectAnswer(value,patientId,model.name),
                          decoration: InputDecoration(
                            hintText: "Write your answer here...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColors.borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColors.borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: AppColors.borderColor),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],

                Spacer(),

                // Navigation buttons
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (controller.currentIndex.value > 0)
                        ElevatedButton(
                          onPressed: ()=>controller.goToPreviousQuestion(model.id, patientId, model.name),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Previous"),
                        )
                      else
                        const SizedBox(),



                      ElevatedButton( onPressed: controller.answers[question.id] == null
                          ? null : ()=>controller.goToNextQuestion(patientId,model.id,model.name),
                        style: ElevatedButton.styleFrom( backgroundColor: const Color(0xFF0D4D54), foregroundColor: Colors.white, ),
                        child: Text( controller.currentIndex.value + 1 < controller.questions.length
                            ? "Next" : "Finish", ), ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

