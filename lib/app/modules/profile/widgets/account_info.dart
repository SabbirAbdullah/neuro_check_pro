import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/modules/profile/widgets/account_info/email_update.dart';

import '../controllers/profile_controller.dart';


class AccountInfo extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(title: 'Account information'),
      body: Obx(() => SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 45,
              backgroundImage: AssetImage("assets/images/user.png"), // Use correct image path
            ),
            const SizedBox(height: 10),
            Text(controller.name.value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                controller.role,
                style: const TextStyle(fontSize: 12, color: Colors.black),
              ),
            ),
            const SizedBox(height: 24),
            sectionHeader(image:'assets/images/edit.png', title: "Basic Info"),
            basicInfoTile("Age", "29 Years"),
            basicInfoTile("Country", "United Kingdom"),
            basicInfoTile("State", controller.state.value),
            basicInfoTile("Post code", controller.postcode.value),
            const SizedBox(height: 20),
            sectionHeader(title: "Login Info"),
            loginInfoTile("Email", "oliver.james@gmail.com", EmailUpdate()),
            loginInfoTile("Phone", "95650356970",EmailUpdate()),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C4A5B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: controller.openEditDialog,
                child: const Text("Edit profile", style: textButton_white),
              ),
            ),
          ],
        ),
      )),
    );
  }
  /// Section header like "Basic Info" or "Login Info"
  Widget sectionHeader({ String ? image , required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          if (image != null)
            Image.asset(
              image,
              width: 20,
              height: 20,
              fit: BoxFit.contain,
            ),


        ],
      ),
    );
  }

  Widget basicInfoTile(String title, String value, ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.black54),
            ),
          ),

        ],
      ),
    );
  }

  Widget loginInfoTile(String title, String value, Widget route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text(
                  value,
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: Colors.black54),
                ),
              SizedBox(width: 4,),
              GestureDetector(
                onTap: (){
                  Get.to(()=>route);
                },
                child: Image.asset(
                  'assets/images/edit.png',
                  width: 20,
                  height: 20,

                ),
              ),
            ],
          ),


        ],
      ),
    );
  }



}
