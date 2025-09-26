import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';

import '../../../core/values/url.dart';
import '../../../core/widgets/custom_loading.dart';
import '../../assessment/controllers/assessment_controller.dart';
import '../../assessment/models/assessment_model.dart';
import '../../patient_profile/controllers/patient_profile_controller.dart';
import '../../patient_profile/widgets/add_patient_form.dart';
import '../controllers/primary_assessment_controller.dart';
import '../views/primary_assessment.dart';
import 'add_child.dart';



class AssessmentChildSelectPage extends StatelessWidget {
  final int assessmentId;

  AssessmentChildSelectPage({super.key,  required this.assessmentId});
  final AssessmentController controller = Get.put(AssessmentController());
  final PatientProfileController patientProfileController = Get.put(PatientProfileController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(title: 'Assessment'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'For whom you are running this assessment?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            Obx((){
              if(patientProfileController.isLoading.value){
                return CustomLoading();
              }
              return  Expanded(
                child: GridView.builder(
                  padding:  EdgeInsets.only(bottom: 40),
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemCount:patientProfileController.patients.length + 1,
                  itemBuilder: (context, index) {

                    if (index < patientProfileController.patients.length ) {
                      final patient = patientProfileController.patients[index];
                      return GestureDetector(
                        onTap: () {
                          Get.snackbar('Selected', 'You selected ${patient.name}');
                          Get.to(()=>InitialAssessmentQuestion(   patient: patient.id,assessmentId: assessmentId));
                          // Get.to(()=>AssessmentPaymentPage(patient: patient, model: model!,));
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.blueAccent.shade100,
                              child: patient.image != null
                                  ? ClipOval(
                                child: Image.network(
                                  ImageURL.imageURL + patient.image!,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                  errorBuilder: (context, error, stackTrace) {
                                    // If image fails to load, show initials
                                    return Center(
                                      child: Text(
                                        patient.name[0].toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                                  : Text(
                                patient.name[0].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              patient.name,
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
                          Get.to(()=>AddPatientForm());
                        },
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 40,
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
              );
            })
          ],
        ),
      ),
    );
  }
}

