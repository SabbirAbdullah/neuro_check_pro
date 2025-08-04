
// pages/assessment_list_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/assessment_controller.dart';
import '../widgets/asseessment_details.dart';


class AssessmentView extends StatelessWidget {

  AssessmentView({super.key});
  final AssessmentController controller = Get.put(AssessmentController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "On-Demand Assessments",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Start a new assessment or view your results to stay informed",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                      () => ListView.builder(
                    itemCount: controller.assessments.length,
                    itemBuilder: (context, index) {
                      final item = controller.assessments[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => AssessmentDetailPage(model: item)),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(item.bgColor),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(item.description, style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
