import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_appbar.dart';
import 'package:neuro_check_pro/app/core/widgets/custom_loading.dart';
import 'package:neuro_check_pro/app/modules/profile/widgets/account_info/email_update.dart';

import '../../../data/model/user_info_model.dart';
import '../../onboardings/controllers/onboarding_controller.dart';
import '../../welcome/controllers/splash_controller.dart';
import '../controllers/profile_controller.dart';


class AccountInfo extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  final UserInfoModel user;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

   AccountInfo({super.key, required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: CustomAppBar(title: 'Account information'),
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),


              Obx(() {
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: controller.selectedImage.value != null
                          ? FileImage(controller.selectedImage.value!)
                          : AssetImage("assets/images/user.png") as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _showImageOptions(context),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                );
              }),
              const SizedBox(height: 10),
              Text(user.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  user.role,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ),
              const SizedBox(height: 24),
              sectionHeader(image:'assets/images/edit.png', title: "Basic Info"),
              basicInfoTile("Age", "${user.age}"),
              basicInfoTile("Country", user.country),
              basicInfoTile("State", user.state),
              basicInfoTile("Post code", user.postCode),
              const SizedBox(height: 20),
              sectionHeader(title: "Login Info"),
              loginInfoTile("Email", user.email, ),
              loginInfoTile("Phone", user.phone,),
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
                  onPressed: openEditDialog,
                  child: const Text("Edit profile", style: textButton_white),
                ),
              ),
            ],
          ),
        ),

    );
  }
  void openEditDialog() {
    // Pre-fill controllers with current user info
    nameController.text = user!.name ?? '';
    stateController.text = user!.state ?? '';
    postCodeController.text = user!.postCode ?? '';
    addressController.text = user!.street ?? '';

    Get.dialog(
      Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: Get.width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  buildTextField("Name", nameController),
                  buildTextField("State", stateController),
                  buildTextField("Post code", postCodeController),
                  buildTextField("Street address", addressController),
                  const SizedBox(height: 16),
                  Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0C4A5B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : () async {
                        // Collect only changed fields
                        Map<String, dynamic> updatedData = {};

                        if (nameController.text.isNotEmpty &&
                            nameController.text != user!.name) {
                          updatedData["name"] = nameController.text;
                        }
                        if (stateController.text.isNotEmpty &&
                            stateController.text != user!.state) {
                          updatedData["state"] = stateController.text;
                        }
                        if (postCodeController.text.isNotEmpty &&
                            postCodeController.text != user.postCode) {
                          updatedData["postCode"] = postCodeController.text;
                        }
                        if (addressController.text.isNotEmpty &&
                            addressController.text != user.street) {
                          updatedData["street"] = addressController.text;
                        }

                        if (updatedData.isEmpty) {
                          Get.back();
                          return;
                        }

                        await controller.updateUserInfo(updatedData);
                      },
                      child: controller.isLoading.value
                          ? CustomLoading()
                          : Text("Save", style: textButton_white),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: 10,),
        Text(label, style: const TextStyle(fontSize: 14,color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
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

  Widget loginInfoTile(String title, String value, ) {
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
              // GestureDetector(
              //   onTap: (){
              //     Get.to(()=>SizedBox());
              //   },
              //   child: Image.asset(
              //     'assets/images/edit.png',
              //     width: 20,
              //     height: 20,
              //
              //   ),
              // ),
            ],
          ),


        ],
      ),
    );
  }
// Show iOS style action sheet
  void _showImageOptions(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        title: Text("Profile Picture"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {

              controller.pickImage();
            },
            child: Text("Upload Image",style: textButton_blue,),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Get.back();
              controller.deleteImage();
            },
            child: Text("Delete Image",style: textButton_red,),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Get.back(),
          child: Text("Cancel",style: textButton_blue,),
        ),
      ),
    );
  }

}




