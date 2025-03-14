import 'dart:convert';
import 'package:flutter/services.dart';

enum Flavor { dev, prod }

class AppConfig {
  static late final String baseUrl;
  static late final String apiKey;
  static late final String imageBaseUrl;
  static late final Flavor flavor;

  static Future<void> initialize({required Flavor flavor}) async {
    AppConfig.flavor = flavor;

    final configFile = await rootBundle.loadString('assets/config/config.json');
    final config = json.decode(configFile) as Map<String, dynamic>;

    baseUrl = config['base_url'] as String;
    apiKey = config['api_key'] as String;
    imageBaseUrl = config['image_base_url'] as String;
  }

  static bool get isDev => flavor == Flavor.dev;
  static bool get isProd => flavor == Flavor.prod;
}
