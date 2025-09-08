// widgets/onboarding_page1.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage1 extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());
   OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF114854),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           CircleAvatar(
            radius: 80,
            backgroundColor: Colors.white,
            child: Text("N", style: TextStyle(fontSize: 100, color: Color(0xFF114854))),
          ),
           SizedBox(height: 30),
           RichText(
               textAlign: TextAlign.center,
             text:
           TextSpan(
             text: 'Welcome to',style:  TextStyle(
             fontSize: 24,
             color: Colors.white,
             fontWeight: FontWeight.w400,
           ),
             children: [

               TextSpan(
                 text: ' NeuroCheckPro',
                 style: TextStyle(
                   fontSize: 24,
                   color: Colors.white,
                   fontWeight: FontWeight.w600,
                 ),
               )
             ]
           ),

           )           ,

          const SizedBox(height: 12),
          const Text(
            "— your trusted companion for fast, affordable screening of neurodevelopmental conditions like Autism and ADHD.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 24),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Get.find<OnboardingController>().nextPage(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              textStyle: TextStyle(fontSize: 16),
              foregroundColor: const Color(0xFF114854),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text("Get Started"),
            ),
          ),
        ],
      ),
    );
  }
}
