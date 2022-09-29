import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/en_lang.dart';
import '../values/vi_lang.dart';

class LocalizationService extends Translations {
  static final locale = _getLocaleFromSupported();
  static const fallbackLocale = Locale('vi', 'VN');
  static final languageCodes = [
    'en',
    'vi',
  ];

  static final List displayLangList = [
    {'name': 'English(US)', 'languageCode': 'en'},
    {'name': 'Tiếng Việt', 'languageCode': 'vi'},
  ];

// các Locale được support
  static final supportedLocales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
  });

  static void changeLocale(String languageCode) {
    final locale = _getLocaleFromSupported(languageCode: languageCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enLanguagePackage,
        'vi_VN': viLanguagePackage,
      };

  static Locale _getLocaleFromSupported({String? languageCode}) {
    final lang = languageCode ?? Get.deviceLocale!.languageCode;
    for (int i = 0; i < languageCodes.length; i++) {
      if (lang == languageCodes[i]) return supportedLocales[i];
    }
    return Get.locale!;
  }
}
