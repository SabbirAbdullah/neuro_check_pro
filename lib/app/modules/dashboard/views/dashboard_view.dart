// screens/dashboard_home.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:neuro_check_pro/app/modules/primary_assessment/widgets/hero_page.dart';
import 'package:neuro_check_pro/app/modules/resume_diagnosis/views/diagnosis_view.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../onboardings/controllers/onboarding_controller.dart';
import '../controllers/dashboard_controller.dart';
class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final DashboardController controller = Get.put(DashboardController());
  final OnboardingController onboardingController = Get.find<OnboardingController>();
  final BottomNavigationController bottomNavController = Get.find<BottomNavigationController>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(

      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top profile + welcome
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage('assets/images/user.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text("Welcome!", style: TextStyle(color: Colors.grey)),
                        Text("${onboardingController.user.value!.name}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ],
                    ),
                    const Spacer(),
                     CircleAvatar(
                      radius: 16,
                      child:Icon(Icons.notifications_active_outlined,color: Colors.grey
                        ,),backgroundColor: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Carousel
                CarouselSlider(
                  options: CarouselOptions(
                    height: screenWidth * 0.4, // Responsive height
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: controller.carouselImages.map((img) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        img,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Explore Assessment
                const Text("Explore Assessment",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () => Get.to(() => const HeroPage()),
                  // replace with HeroPage()
                  child: _assessmentCard(
                    title: "Primary Self-Assessment",
                    desc:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                    color: const Color(0xFFE5F6FE),
                  ),
                ),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: (){
                    bottomNavController.changeTab(1);
                  },
                  child: _assessmentCard(
                    title: "Clinical Assessment",
                    desc:
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                    color: const Color(0xFFFFE6E1),
                    icon: 'assets/images/clinical_assessment.png',
                  ),
                ),
                const SizedBox(height: 12),

                GestureDetector(
                  onTap: () {
                    Get.to(() => DiagnosisView());
                  },
                  child: _assessmentCard(
                    title: "Resume Diagnosis",
                    desc: "See all incomplete diagnosis",
                    color: const Color(0xFF114854),
                    textColor: Colors.white,
                    icon: 'assets/images/resume.png',
                  ),
                ),
                const SizedBox(height: 20),

                // Do you know section
                const Text("Do you know?",
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(

                    children: [
                  Container(
                    width: MediaQuery.of(context).size.width *.65,
                    height:  MediaQuery.of(context).size.height *.15,
                  margin:  EdgeInsets.only(right: 8),
                  padding:  EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0x1F050222),
                        Color(0x1fa49fd4),  Color(0x1fa49fd4),

                      ],),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text("🧠 Early intervention can make a big difference",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                      Text(
                          "Timely diagnosis and treatment can significantly improve communication, behavior, and learning skills in children with Autism and ADHD.",
                           overflow: TextOverflow.ellipsis,maxLines: 3,
                        style: const TextStyle(color: Colors.black, fontSize: 10,fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                      Container(
                        width: MediaQuery.of(context).size.width *.65,
                        height:  MediaQuery.of(context).size.height *.15,
                        margin:  EdgeInsets.only(right: 8),
                        padding:  EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0x1F050222),
                              Color(0x1fa49fd4),  Color(0x1fa49fd4),

                            ],),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text("🧠 Early intervention can make a big difference",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                            Text(
                              "Timely diagnosis and treatment can significantly improve communication, behavior, and learning skills in children with Autism and ADHD.",
                              overflow: TextOverflow.ellipsis,maxLines: 3,
                              style: const TextStyle(color: Colors.black, fontSize: 10,fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Assessment Card Widget
  Widget _assessmentCard({
    required String title,
    required String desc,
    required Color color,
    String? icon,
    Color textColor = Colors.black,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: TextStyle(
                      color: textColor.withOpacity(0.8), fontSize: 13),
                ),
              ],
            ),
          ),
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(icon, width: 40, height: 40),
            ),
        ],
      ),
    );
  }

// Info card widget
}
