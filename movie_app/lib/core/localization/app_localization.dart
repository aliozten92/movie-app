import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalization {
  final Locale locale;
  AppLocalization(this.locale);

  static AppLocalization of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization)!;
  }

  Map<String, dynamic>? _localizedValues;

  Future<void> load() async {
    String jsonStringValues = await rootBundle
        .loadString('assets/translations/${locale.languageCode}.json');
    _localizedValues = json.decode(jsonStringValues);
  }

  String translate(String key) {
    if (_localizedValues == null) return key;

    List<String> keys = key.split('.');
    dynamic value = _localizedValues;

    for (String k in keys) {
      if (value == null) return key;
      value = value[k];
    }

    return value?.toString() ?? key;
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _AppLocalizationDelegate();
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_AppLocalizationDelegate old) => false;
}
