import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/assessment_history/views/assessment_history_view.dart';
import 'package:neuro_check_pro/app/modules/billing_info/views/bill_info_view.dart';
import 'package:neuro_check_pro/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:neuro_check_pro/app/modules/patient_profile/views/patient_profile_view.dart';
import 'package:neuro_check_pro/app/modules/privacy_security/views/privacy_security_view.dart';
import 'package:neuro_check_pro/app/modules/privacy_security/widgets/about_neurocheckpro.dart';
import 'package:neuro_check_pro/app/modules/welcome/controllers/splash_controller.dart';

import '../../../core/values/url.dart';
import '../../onboardings/controllers/onboarding_controller.dart';
import '../../privacy_security/widgets/privacy_policy.dart';
import '../../privacy_security/widgets/terms_conditions.dart';
import '../controllers/profile_controller.dart';
import '../widgets/account_info.dart';


class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());
  final SplashController splashController = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh:splashController.fetchUserInfo,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 24),
                _buildHeader(context),
                const SizedBox(height: 28),
                _quickAccessTiles(),
                const SizedBox(height: 24),
                _sectionTitle("User information"),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>AccountInfo(user: splashController.user.value!,),);
                  },
                    child: _infoTile("Account information")),
                GestureDetector(
                  onTap: (){
                    Get.to(()=>BillingPage());
                  },
                    child: _infoTile("Billing information")),
                GestureDetector(
                    onTap: (){
                      Get.to(()=>PrivacySecurityView());
                    },
                    child: _infoTile("Privacy and Security")),
                const SizedBox(height: 24),
                _sectionTitle("User policy"),
                GestureDetector(
                    onTap: ()=> Get.to(()=>PrivacyPolicyView()),
                    child: _linkText("Privacy policy", Colors.grey)),
                GestureDetector(
                  onTap: ()=> Get.to(()=>TermsConditions()),
                    child: _linkText("Terms & conditions", Colors.grey)),
                GestureDetector(
                    onTap: ()=>Get.to(()=>AboutNeuroCheckPro()),
                    child: _linkText("About Neurocheckpro",Colors.grey)),
                GestureDetector(
                  onTap: (){
                    controller.logout();
                  },
                    child: _linkText("Logout",Colors.red)),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueAccent.shade100,
              child: splashController.user.value!.image != null
                  ? ClipOval(
                child: Image.network(
                  ImageURL.imageURL + splashController.user.value!.image!,
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) {
                    // If image fails to load, show initials
                    return Center(
                      child: Text(
                        splashController.user.value!.name[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              )
                  : Text(
                splashController.user.value!.name[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                splashController.user.value!.role,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            )
          ],
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome!",
              style: TextStyle(
                color: Color(0xFF104E59),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
             "${splashController.user.value!.name}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              splashController.user.value!.email,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _quickAccessTiles() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.4,
      children: [
        GestureDetector(
          onTap: (){
            Get.to(()=>AssessmentHistoryView());
          },
            child: _tileBox("Assessment\nhistory","assets/images/assessment_history.png")),
        GestureDetector(
            onTap: (){
              Get.to(()=>PatientProfileView());
            },
            child: _tileBox("Patient\nprofiles", "assets/images/patient_profile.png")),
      ],
    );
  }
  String initials(String name) {
    final parts = name.split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Widget _tileBox(String text, String image) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFCEAE9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none, // allows icon to overflow outside
        children: [
          // Arrow icon (top-right)
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.arrow_outward,
              color: const Color(0xFF104E59),
              size: 22,
            ),
          ),

          // Text (top-left)
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF8C5A5A),
              ),
            ),
          ),

          // 3D custom icon (bottom-right)
          Positioned(
            right: -10,  // overflow effect
            bottom: -20, // overflow effect
            child: Image.asset(
              image, // <-- your PNG
              height: 80,
              width: 80,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _infoTile(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 15)),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _linkText(String text, Color ? color) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style:  TextStyle(
          fontSize: 14,
          color: color,
        ),
      ),
    );
  }

}
