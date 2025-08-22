// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class QuestionLocalDataSource {
//   Future<void> saveProgress(int assessmentId, int lastAnsweredIndex) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setInt("progress_$assessmentId", lastAnsweredIndex);
//   }
//
//   Future<int> getProgress(int assessmentId) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getInt("progress_$assessmentId") ?? 0;
//   }
//
//   Future<void> saveAnswers(int assessmentId, Map<int, String> answers) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString("answers_$assessmentId", jsonEncode(answers));
//   }
//
//   Future<Map<int, String>> getAnswers(int assessmentId) async {
//     final prefs = await SharedPreferences.getInstance();
//     final data = prefs.getString("answers_$assessmentId");
//     if (data == null) return {};
//     return Map<int, String>.from(jsonDecode(data));
//   }
// }
