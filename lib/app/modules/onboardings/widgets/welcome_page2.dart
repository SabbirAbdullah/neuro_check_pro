import 'package:flutter/material.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image

             Container(
               height: MediaQuery.of(context).size.height*.5,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/onboard2.png"),
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
            padding: const EdgeInsets.only(top: 50.0,left: 20,right: 20),
            child: Flexible(
                  child: Text(
                    "Start with a quick screening quiz. Based on your answers, we’ll let you know if a full assessment is recommended.",
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
