import 'package:logger/logger.dart';

import '/app/core/values/app_values.dart';
class AppValues {
  static const int loggerMethodCount = 2;
  static const int loggerErrorMethodCount = 8;
  static const int loggerLineLength = 120;
}
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