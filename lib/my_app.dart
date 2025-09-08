import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../flavors/build_config.dart';
import '../flavors/env_config.dart';
import 'app/bindings/initial_binding.dart';
import 'app/core/values/app_colors.dart';
import 'app/data/repository/auth_repository.dart';
import 'app/data/repository/pref_repository.dart';
import 'app/routes/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
   void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final EnvConfig envConfig = BuildConfig.instance.config;
    return GetMaterialApp(

      defaultTransition: Transition.leftToRight,
      initialRoute: AppPages.INITIAL,
      initialBinding: InitialBinding(),
      title: envConfig.appName,
      getPages: AppPages.routes,

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w600),
            iconTheme: IconThemeData(color: Colors.white, ), ),
        primarySwatch: AppColors.colorPrimarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: AppColors.colorPrimary,
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),

      ),
      debugShowCheckedModeBanner: false,

    );
  }

}
