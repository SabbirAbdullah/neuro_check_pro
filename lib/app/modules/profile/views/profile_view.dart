import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';
import '../widgets/account_info.dart';


class ProfileView extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
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
                  Get.to(()=>AccountInfo(),);
                },
                  child: _infoTile("Account information")),
              _infoTile("Billing information"),
              _infoTile("Privacy and Security"),
              const SizedBox(height: 24),
              _sectionTitle("User policy"),
              _linkText("Privacy policy"),
              _linkText("Terms & conditions"),
              _linkText("About Neurocheckpro"),
              const SizedBox(height: 40),
            ],
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
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/user.png'), // Your image
            ),
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
             "${ controller.name}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              controller.email,
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
        _tileBox("Assessment\nhistory"),
        _tileBox("Patient\nprofiles"),
      ],
    );
  }

  Widget _tileBox(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFCEAE9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(Icons.open_in_new, color: const Color(0xFF104E59), size: 18),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF8C5A5A),
              ),
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

  Widget _linkText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }

}
