import 'package:flutter/material.dart';

enum Flavor {
  dev,
  qa,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Movie App DEV';
      case Flavor.qa:
        return 'Movie App QA';
      case Flavor.prod:
        return 'Movie App';
      default:
        return 'Movie App';
    }
  }

  static bool get isDev => appFlavor == Flavor.dev;
  static bool get isQa => appFlavor == Flavor.qa;
  static bool get isProd => appFlavor == Flavor.prod;

  static Color get bannerColor {
    switch (appFlavor) {
      case Flavor.dev:
        return Colors.red;
      case Flavor.qa:
        return Colors.purple;
      case Flavor.prod:
        return Colors.transparent;
      default:
        return Colors.transparent;
    }
  }

  static String get bannerText {
    switch (appFlavor) {
      case Flavor.dev:
        return 'DEV';
      case Flavor.qa:
        return 'QA';
      case Flavor.prod:
        return '';
      default:
        return '';
    }
  }
}
