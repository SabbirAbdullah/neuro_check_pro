import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/assessment_controller.dart';
import '../models/assessment_model.dart';


class QuestionPage extends StatelessWidget {
  final AssessmentModel model;
  final AssessmentController controller = Get.put(AssessmentController());

  QuestionPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    controller.loadQuestions(model.id);

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
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (controller.questions.isEmpty) {
          return const Scaffold(
            body: Center(child: Text("No questions found")),
          );
        }

        final question = controller.questions[controller.currentIndex.value];
        final selected = controller.answers[question.id] ?? "";

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
                Text("${controller.currentIndex.value + 1} / ${ controller.questions.length}",
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
                ...["Yes", "No"].map((option) {
                  final isSelected = selected == option;
                  return GestureDetector(
                    onTap: () => controller.selectAnswer(option),
                    child: Container(
                      margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
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
                            : controller.goToNextQuestion,
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
          ),
        );
      }),
    );
  }
}

class QuestionSummary extends StatelessWidget {
  final AssessmentController controller;
  const QuestionSummary({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summary")),
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
                        Text("Answer: $ans"),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.snackbar("Submitted", "Your answers have been saved!");
                // later: call API here to submit controller.answers
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D4D54),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text("Submit All",
                    style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
