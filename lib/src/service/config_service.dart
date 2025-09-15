import 'dart:convert';

import '../config/app_config.dart';

class ConfigService {
  static Future<AppConfig> loadConfig(String content) async {
    try {
      final jsonMap = jsonDecode(content) as Map<String, dynamic>;
      final config = AppConfig.fromJson(jsonMap);

      return config;
    } catch (e) {
      throw ConfigParseException('Failed to load config: $e');
    }
  }

  static Future<String> saveConfig(AppConfig config) async {
    final jsonString = jsonEncode(config.toJson());
    return jsonString;
  }
}

class ConfigParseException implements Exception {
  final String message;
  ConfigParseException(this.message);

  @override
  String toString() => 'ConfigParseException: $message';
}
