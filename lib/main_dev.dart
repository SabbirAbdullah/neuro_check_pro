import 'package:flutter/material.dart';


import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  EnvConfig devConfig = EnvConfig(
    appName: "",
    baseUrl: "https://neurocheckpro.com/api",
    shouldCollectCrashLog: true,

  );
  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  runApp(const MyApp());
}


