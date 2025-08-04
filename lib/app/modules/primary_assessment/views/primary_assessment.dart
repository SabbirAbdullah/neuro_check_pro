import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';

import '../controllers/primary_assessment_controller.dart';
import '../widgets/quiz_results.dart';


class PrimaryAssessmentView extends StatelessWidget {
   PrimaryAssessmentView({super.key});
  final PrimaryAssessmentController controller = Get.put(PrimaryAssessmentController());
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
        final questionData = controller.questions[controller.currentQuestionIndex.value];
        final selected = controller.selectedAnswers[controller.currentQuestionIndex.value];

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: (controller.currentQuestionIndex.value + 1) / controller.questions.length,
                backgroundColor: Colors.grey.shade300,
                color: const Color(0xFF0D4D54),
              ),
              const SizedBox(height: 8),
              Text("${controller.currentQuestionIndex.value + 1} / 10",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  questionData['question'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(questionData['options'].length, (i) {
                final option = questionData['options'][i];
                final isSelected = selected == option;

                return GestureDetector(
                  onTap: () => controller.selectAnswer(controller.currentQuestionIndex.value, option),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0D4D54).withOpacity(0.05) : Colors.white,
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
              }),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: selected.isNotEmpty ? controller.goToNextQuestion : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D4D54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    controller.currentQuestionIndex.value == 9 ? 'Submit' : 'Continue',
                    style: textButton_white
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
    );
  }
}

class QuizSummaryPage extends StatelessWidget {

  final PrimaryAssessmentController controller = Get.put(PrimaryAssessmentController());
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text("", style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Take final glance on your answers and then\nSubmit to get score",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: controller.questions.length,
                itemBuilder: (context, index) {
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
                        Text(
                          controller.questions[index]['question'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.circle, size: 10, color: Color(0xFF0D4D54)),
                            const SizedBox(width: 6),
                            Text(controller.selectedAnswers[index]),
                            const Spacer(),
                            Text("${index + 1}", style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("< Previous", style: TextStyle(color: Color(0xFF0D4D54))),
                ),
                ElevatedButton(
                  onPressed: (){ Get.snackbar("Submitted", "Your answers have been submitted.");
                  final score = controller.calculateScore();
                  Get.to(() => PrimaryQuizResultView(score: score));


                  },
                  
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D4D54),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text("Submit",style: textButton_white,),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
