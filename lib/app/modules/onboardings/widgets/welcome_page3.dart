// widgets/onboarding_page2.dart
import 'package:flutter/material.dart';

import '../../../core/values/app_colors.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image

        Container(
          height: MediaQuery.of(context).size.height*.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/onboard4.png"),
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
            padding: const EdgeInsets.only(top: 80.0,left: 20,right: 20),
            child:  Text(
                "If recommended, you can proceed to a full assessment reviewed by expert clinicians for a reliable diagnosis.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,

                ),
              ),

          ),


        ),

      ],
    );
  }
}
