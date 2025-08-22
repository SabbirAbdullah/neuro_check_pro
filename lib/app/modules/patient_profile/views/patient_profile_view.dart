import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_button.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';

import '../../../core/values/app_colors.dart';
import '../controllers/patient_profile_controller.dart';
import '../models/patient_profile_model.dart';
import '../widgets/add_patient_form.dart';
import '../widgets/patient_details.dart';


class PatientProfileView extends StatelessWidget {
   PatientProfileView({super.key});
   final PatientProfileController controller = Get.put(PatientProfileController());
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(title: "Patient Profile"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoading());
        }
        if (controller.patients.isEmpty) {
          // Empty state
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 120,
                    child: Icon(CupertinoIcons.person_2_fill, size: 90, color: Colors.blueGrey[200]),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'No child added',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Add a child profile to start tracking therapy, sessions and appointments.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          );
        }

        // List of children
        return ListView.builder(
            itemCount: controller.patients.length,
            itemBuilder:(context,index){
              final patient = controller.patients[index];
              return
              ChildCard(patient: patient);
            } );
      }),

      // Floating add button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // ✅ Center at bottom
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // ✅ Equal padding on both sides
        child: CustomButton(
          text: 'Add Child',
          onPressed: () {
            Get.to(()=>AddPatientForm());
          },
        ),
      ),

    );
  }
}

class ChildCard extends StatelessWidget {
  final PatientModel patient;
  const ChildCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ChildDetailPage(child: patient)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: AppColors.borderColor,width: 1))
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30 ,
              backgroundColor: Colors.blueAccent.shade100,
              child: patient.imageUrl == null
                  ? Text(patient.initials('child'), style: const TextStyle(fontSize: 18, color: Colors.white))
                  : null,
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Text(
                      '${calculateAge (patient.dateOfBirth)} years',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  int calculateAge(String dob) {
    final birthDate = DateTime.parse(dob);
    final today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}



