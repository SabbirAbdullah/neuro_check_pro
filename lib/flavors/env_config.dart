import 'package:logger/logger.dart';

import '/app/core/values/app_values.dart';

class EnvConfig {
  final String appName;
  final String baseUrl;
  final bool shouldCollectCrashLog;
  late final Logger logger;

  EnvConfig({
    required this.appName,
    required this.baseUrl,
    this.shouldCollectCrashLog = false,
  }) {
    logger = Logger(
      printer: PrettyPrinter(
        methodCount: AppValues.loggerMethodCount,
        errorMethodCount: AppValues.loggerErrorMethodCount,
        lineLength: AppValues.loggerLineLength,
        colors: true,
        printEmojis: true,
        printTime: false,
      ),
    );
  }
}