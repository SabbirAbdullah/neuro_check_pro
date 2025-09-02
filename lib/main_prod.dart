import 'package:flutter/material.dart';

import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'my_app.dart';

void main() {
  EnvConfig prodConfig = EnvConfig(
    appName: "",
    baseUrl: "http://192.168.0.105:3000",
    shouldCollectCrashLog: true,
  );
  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: prodConfig,
  );

  runApp(const MyApp());
}
