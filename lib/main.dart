
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'flavors/build_config.dart';
import 'flavors/env_config.dart';
import 'flavors/environment.dart';
import 'app/my_app.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EnvConfig prodConfig = EnvConfig(
    appName: "",
    baseUrl: "https://neurocheckpro.com/api",
    shouldCollectCrashLog: true,
  );
  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: prodConfig,
  );

  runApp(const MyApp());
}
