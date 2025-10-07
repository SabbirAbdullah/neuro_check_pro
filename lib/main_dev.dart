
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import '/flavors/build_config.dart';
import '/flavors/env_config.dart';
import '/flavors/environment.dart';
import 'app/my_app.dart';
import 'firebase_options.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  EnvConfig devConfig = EnvConfig(
    appName: "",
    baseUrl: "https://api.neurocheckpro.com",
    shouldCollectCrashLog: true,

  );
  BuildConfig.instantiate(
    envType: Environment.DEVELOPMENT,
    envConfig: devConfig,
  );

  runApp(const MyApp());
}


