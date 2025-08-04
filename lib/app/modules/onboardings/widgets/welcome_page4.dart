// widgets/onboarding_page2.dart
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';


class OnboardingPage4 extends StatelessWidget {
  const OnboardingPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image

        Container(
          height: MediaQuery.of(context).size.height*.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/onboard3.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.appPrimaryColor, AppColors.appPrimaryColor,Colors.transparent],
            ),
          ),
        ),



        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 90.0,left: 20,right: 20),
            child: Flexible(
              child: Text(
                "NeuroCheckPro is developed and managed by a team of experts in neurodevelopment. We’re constantly improving with the latest research to provide you with the best care possible.To start the Quiz, Sign In first!  ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,

                ),
              ),
            ),
          ),


        ),

      ],
    );
  }
}
