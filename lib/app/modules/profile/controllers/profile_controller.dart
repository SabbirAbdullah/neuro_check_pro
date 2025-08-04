import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';

class ProfileController extends GetxController {
  final String email = "oliver.james@gmail.com";
  final String role = "Parent";

  var name = 'Oliver James Bennett'.obs;
  var state = 'Manchester'.obs;
  var postcode = 'M14 5LT'.obs;
  var address = '42 Maple Grove'.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void openEditDialog() {
    nameController.text = name.value;
    stateController.text = state.value;
    postcodeController.text = postcode.value;
    addressController.text = address.value;

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
                  Text("Edit Profile",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                  buildTextField("Name", nameController),
                  buildTextField("State", stateController),
                  buildTextField("Post code", postcodeController),
                  buildTextField("Street address", addressController),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C4A5B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      name.value = nameController.text;
                      state.value = stateController.text;
                      postcode.value = postcodeController.text;
                      address.value = addressController.text;
                      Get.back();
                    },
                    child: const Text("Save",style: textButton_white,),
                  ),
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
}
