import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/core/values/app_colors.dart';
import 'package:neuro_check_pro/app/core/values/text_styles.dart';

AppBar CustomAppBar({required String title, bool showBack = true}) {
  return AppBar(
    backgroundColor: AppColors.appBarColor,
    title: Text(title),
    leading: showBack
        ? IconButton(
      icon: Icon(Icons.arrow_back_ios_new), // Your preferred icon
      onPressed: () => Get.back(), // or Navigator.pop(context)
    )
        : null,
  );
}
