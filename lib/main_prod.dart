import 'package:flutter/material.dart';

import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'my_app.dart';
//01833947894
//112233
//AHB-0211
//5431
void main() {
  EnvConfig prodConfig = EnvConfig(
    appName: "",
    baseUrl: "",
    shouldCollectCrashLog: true,
  );
  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: prodConfig,
  );

  runApp(const MyApp());
}
