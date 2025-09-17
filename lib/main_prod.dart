import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'app/my_app.dart';
import 'firebase_options.dart';
// https://neurocheckpro.com/api
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EnvConfig devConfig = EnvConfig(
    appName: "",
    baseUrl: "http://35.179.110.216:3000/api",
    shouldCollectCrashLog: true,

  );
  BuildConfig.instantiate(
    envType: Environment.PRODUCTION,
    envConfig: devConfig,
  );

  runApp(const MyApp());
}
