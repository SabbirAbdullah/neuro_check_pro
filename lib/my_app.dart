import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../flavors/build_config.dart';
import '../flavors/env_config.dart';
import 'app/bindings/initial_binding.dart';
import 'app/core/values/app_colors.dart';
import 'app/routes/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
   void initState()  {
    //  _getTokenData();
    super.initState();
    // initialization();
  }
  final EnvConfig _envConfig = BuildConfig.instance.config;


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      defaultTransition: Transition.leftToRight,
      initialRoute: AppPages.INITIAL,
      initialBinding: InitialBinding(),
      title: _envConfig.appName,
      getPages: AppPages.routes,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: _getSupportedLocal(),

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
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,

    );
  }
  List<Locale> _getSupportedLocal() {
    return [
      const Locale('en', ''),
      const Locale('bn', ''),
    ];
  }
}
