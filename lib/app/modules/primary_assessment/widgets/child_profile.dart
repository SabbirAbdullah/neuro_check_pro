import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

import '../controllers/primary_assessment_controller.dart';
import '../views/primary_assessment.dart';
import 'add_child.dart';



class AssessmentChildSelectPage extends StatelessWidget {
  const AssessmentChildSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PrimaryAssessmentController controller = Get.put(PrimaryAssessmentController());

    return Scaffold(
      appBar: CustomAppBar(
        title:'Assessment'),

      body: Obx(() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'For whom you are running this assessment?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1,
                ),
                itemCount: controller.children.length + 1,
                itemBuilder: (context, index) {
                  if (index < controller.children.length) {
                    final child = controller.children[index];
                    return GestureDetector(
                      onTap: () {
                        Get.snackbar('Selected', 'You selected ${child.name}');
                        Get.to(()=>PrimaryAssessmentView());
                        // Proceed to next page
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(child.imagePath),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            child.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: (){

                        Get.to(()=>NewProfileView());

                        },
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Color(0xFFE1E8EA),
                            child: Icon(Icons.add, size: 32, color: Colors.black45),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Add new',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
