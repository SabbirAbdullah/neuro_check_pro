import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/primary_assessment/models/child_profile_model.dart';
import 'package:neuro_check_pro/app/modules/primary_assessment/widgets/add_child.dart';

import '../views/primary_assessment.dart';
import '../widgets/child_profile.dart';
import '../widgets/quiz_results.dart';

class PrimaryAssessmentController extends GetxController {

  RxList<ChildProfileModel> children = <ChildProfileModel>[
    ChildProfileModel(name: 'Oliver', imagePath: 'assets/images/user.png'),
    ChildProfileModel(name: 'Amelia', imagePath: 'assets/images/user.png'),
    ChildProfileModel(name: 'George', imagePath: 'assets/images/user.png'),

  ].obs;

  var currentQuestionIndex = 0.obs;
  var selectedOptionIndex = (-1).obs;
  RxList<String> selectedAnswers = List.filled(10, '').obs;

  // Scoring rule mapping
  final Set<int> scoreIfAgree = {1, 7, 8, 10}; // 1-based index
  final Set<int> scoreIfDisagree = {2, 3, 4, 5, 6, 9};

  List<Map<String, dynamic>> questions = [
    {
      'question': "I often notice small sounds when others do not.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "I usually concentrate more on the whole picture, rather than the small details.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "I find it easy to do more than one thing at once.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "If there is an interruption, I can switch back to what I was doing very quickly.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "I find it easy to 'read between the lines' when someone is talking to me.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "I know how to tell if someone listening to me is getting bored.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "When I'm reading a story I find it difficult to work out the characters’ intentions.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "I like to collect information about categories of things (e.g. types of car, bird, train, plant etc.)",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "I find it easy to work out what someone is thinking or feeling just by looking at their face.",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
    {
      'question': "I find it difficult to work out people’s intentions",
      'options': ['Definitely agree', 'Slightly agree', 'Slightly disagree', 'Definitely disagree']
    },
  ];

  void selectAnswer(int index, String answer) {
    selectedAnswers[index] = answer;
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < 9) {
      currentQuestionIndex++;
    } else {
      final score = calculateScore();
      Get.to(() => QuizSummaryPage());
    }
  }

  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
    }
  }

  int calculateScore() {
    int score = 0;

    for (int i = 0; i < selectedAnswers.length; i++) {
      final ans = selectedAnswers[i];
      final qNum = i + 1; // 1-based

      if (scoreIfAgree.contains(qNum) &&
          (ans == 'Definitely agree' || ans == 'Slightly agree')) {
        score++;
      }

      if (scoreIfDisagree.contains(qNum) &&
          (ans == 'Definitely disagree' || ans == 'Slightly disagree')) {
        score++;
      }
    }

    return score;
  }


  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final gpController = TextEditingController();
  final tagController = TextEditingController();

  RxString gender = ''.obs;
  RxString relationship = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return  Column(
            children: [
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: selectedDate.value ?? DateTime.now(),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (date) {
                    selectedDate.value = date;
                    dobController.text =
                    "${date.day} ${_monthName(date.month)} ${date.year}";
                  },
                ),
              ),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Done", style: TextStyle(color: Colors.blue)),
              )
            ],
          );
      },
    );
  }

  Future<void> submit() async {

    await Future.delayed(Duration(seconds: 1));
    Get.back();
    Get.snackbar(
      "Success",
      "A new patient has been added",
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(
        bottom: Get.height / 2 - 40,
        left: 20,
        right: 20,
      ),
      // Show for 2 seconds
    );
  }


  String _monthName(int month) {
    const months = [
      '', 'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month];
  }
}

