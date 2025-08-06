import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssessmentHistoryController extends GetxController{
  final assessments = [
    {
      'title': 'Initial Assessment',
      'date': '20 July, 2025',
      'status': 'Completed',
      'statusColor': Color(0xff32B355),
      'bgColor': const Color(0xFFF5F1FF),
      'buttonText': 'View details',
    },
    {
      'title': 'Child Autism Diagnosis',
      'date': '20 July, 2025',
      'status': 'Reviewing',
      'statusColor': Colors.yellow.shade700,
      'bgColor': const Color(0xFFE3F3FF),
      'buttonText': 'View details',
    },
    {
      'title': 'Child Autism Diagnosis',
      'date': '20 July, 2025',
      'status': 'Pending',
      'statusColor': Colors.yellow.shade300,
      'bgColor': const Color(0xFFE6F4FD),
      'buttonText': 'Continue',
    },
  ];
}