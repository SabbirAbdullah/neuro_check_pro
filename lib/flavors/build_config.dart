import '/flavors/env_config.dart';
import '/flavors/environment.dart';

class BuildConfig {
  static final BuildConfig instance = BuildConfig._internal();

  late final Environment environment;
  late final EnvConfig _config;
  bool _lock = false;

  BuildConfig._internal();

  /// Call this once to initialize
  factory BuildConfig.instantiate({
    required Environment envType,
    required EnvConfig envConfig,
  }) {
    if (instance._lock) return instance;

    instance.environment = envType;
    instance._config = envConfig;
    instance._lock = true;

    return instance;
  }

  /// Use this safely after instantiation
  static EnvConfig get config {
    assert(instance._lock, 'BuildConfig not initialized!');
    return instance._config;
  }
}