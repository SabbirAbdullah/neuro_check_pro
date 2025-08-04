import 'package:flutter/material.dart';


import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'my_app.dart';

void main() {
  EnvConfig prodConfig = EnvConfig(
    appName: "",
    baseUrl: "",
    shouldCollectCrashLog: true,

  );
  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: prodConfig,
  );

  runApp(const MyApp());
}


