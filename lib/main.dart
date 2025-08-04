
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'my_app.dart';


void main()  {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();
  // final welcomeController = Get.put(WelcomeController());
  // await welcomeController.checkLoginStatus();
  runApp(const MyApp());
}
