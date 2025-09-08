// screens/dashboard_main.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/profile/views/profile_view.dart';
import 'package:neuro_check_pro/app/modules/welcome/controllers/splash_controller.dart';

import '../../assessment/views/assessment_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../onboardings/controllers/onboarding_controller.dart';
import '../controllers/bottom_navigation_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationView extends StatelessWidget {
  BottomNavigationView({super.key});

  final BottomNavigationController controller = Get.put(BottomNavigationController());
  final OnboardingController onboardingController = Get.find<OnboardingController>();
  final pages = [
    DashboardView(),
    AssessmentView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color(0xFF114654),
                color: Colors.grey,
                tabs:  [
                  GButton(

                    icon: CupertinoIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: CupertinoIcons.doc_text_search,
                    text: 'Assessment',
                  ),
                  GButton(
                    icon: CupertinoIcons.person,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: controller.currentIndex.value,
                onTabChange: controller.changeTab,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

