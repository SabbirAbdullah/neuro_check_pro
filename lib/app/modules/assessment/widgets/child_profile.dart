import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';
import 'package:neuro_check_pro/app/modules/assessment/widgets/assessment_payment_page.dart';

import '../../patient_profile/controllers/patient_profile_controller.dart';
import '../../patient_profile/widgets/add_patient_form.dart';
import '../../primary_assessment/widgets/add_child.dart';
import '../controllers/assessment_controller.dart';
import '../models/assessment_model.dart';



class ChildProfile extends StatelessWidget {
  final AssessmentModel model;

  ChildProfile({super.key, required this.model});
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
                     final child = patientProfileController.patients[index];
                     return GestureDetector(
                       onTap: () {
                         Get.snackbar('Selected', 'You selected ${child.name}');
                         Get.to(()=> AssessmentPaymentPage(child: child,model: model,));
                       },
                       child: Column(
                         children: [
                           CircleAvatar(
                               radius: 40,
                               child: child.imageUrl == null
                                   ?Text(child.initials('child'), style:  TextStyle(fontSize: 18, color: Colors.white))
                                   :Image.network(child.imageUrl!)

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
