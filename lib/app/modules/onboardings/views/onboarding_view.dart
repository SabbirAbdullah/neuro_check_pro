// screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/modules/authentication/signin/views/signin_view.dart';
import '../../authentication/signin/widgets/email_signin.dart';
import '../../authentication/signup/views/signup_view.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/welcome_page1.dart';
import '../widgets/welcome_page2.dart';
import '../widgets/welcome_page3.dart';
import '../widgets/welcome_page4.dart';

class OnboardingView extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController(),permanent: true);

  final List<Widget> pages = [
     OnboardingPage1(),
    const OnboardingPage2(),
    const OnboardingPage3(),
    const OnboardingPage4(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack(
        children: [
          pages[controller.currentPage.value],
          Positioned(
            top: 50,
            right: 20,
            child: controller.currentPage.value > 0
                ? TextButton(
              onPressed: controller.skipToLast,
              child: const Text("Skip", style:onBoardingTextButton_white),
            )
                : const SizedBox(),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                controller.currentPage.value > 0
                    ? TextButton(
                  onPressed: controller.previousPage,
                  child: const Text("Previous",style: onBoardingTextButton_white,),
                )
                    : const SizedBox(),
                Row(
                  children: List.generate(4, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: controller.currentPage.value == index
                            ? Colors.white
                            : Colors.white60,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                controller.currentPage.value > 0
                    ? TextButton(
                  onPressed: (){
                    controller.nextPage();
                  if ( controller.currentPage.value == 3)
                    {
                      Get.to(()=> SignInView());
                    }

                  },
                  child: const Text("Next",style: onBoardingTextButton_white,),
                )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
