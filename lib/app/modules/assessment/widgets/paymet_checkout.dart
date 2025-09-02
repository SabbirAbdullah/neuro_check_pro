import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';

import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';
import 'package:neuro_check_pro/app/modules/assessment/widgets/question_page.dart';
import 'package:neuro_check_pro/app/modules/patient_profile/models/patient_profile_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../controllers/assessment_controller.dart';
import '../models/assessment_model.dart';

class CheckoutPage extends StatelessWidget {
  final AssessmentModel model;
  final PatientModel patient;

  const CheckoutPage({super.key, required this.model, required this.patient, });

  @override
  Widget build(BuildContext context) {
    final AssessmentController controller = Get.put(AssessmentController());

    return Scaffold(
      appBar: AppBar(title: const Text("Payment Checkout")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CustomLoading());
        }

        if (controller.checkoutUrl.isNotEmpty) {
          return WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(
                NavigationDelegate(
                  onPageFinished: (url) {
                    if (url.contains("success")) {
                      Get.off(() =>  PaymentSuccessPage(model: model,patient: patient,));
                    }
                  },
                ),
              )
              ..loadRequest(Uri.parse(controller.checkoutUrl.value)),
          );
        }

        return Container();
      }),
    );
  }
}


class PaymentSuccessPage extends StatelessWidget {
   PaymentSuccessPage({super.key, required this.model, required this.patient});
  final AssessmentModel model;
   final PatientModel patient;


  @override
  Widget build(BuildContext context) {
    final AssessmentController controller = Get.put(AssessmentController());
    return Scaffold(
      // appBar: CustomAppBar(title: "Payment Success",),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Icon(
              CupertinoIcons.check_mark_circled_solid,
              size: 100,
              color: CupertinoColors.activeGreen,
            ),
            SizedBox(height: 20),
            Text(
              "Payment Successful!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.label,
              ),
            ),
            SizedBox(height: 40),
            CupertinoButton.filled(
              color: AppColors.appBarColor,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child:  Text("Start Your Assessment"),
              onPressed: () {
                controller.loadQuestions(model.id);
                Get.off(()=>QuestionPage(patient: patient));
              },
            ),
            SizedBox(height: 16,),
            CupertinoButton.filled(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child:  Text("Go To Dashboard",style: TextStyle(color: Colors.black),),
              onPressed: () {
                Get.put(BottomNavigationController());
                Get.offNamed("/bottom_navigation_view");
              },
            ),
            Spacer(flex: 1,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.info_outline, color: Colors.grey),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Your can start your assessment later",
                        style: TextStyle(color: Colors.grey,fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),


          ],
        ),
      ),
    );
  }
}
