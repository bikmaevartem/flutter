import 'package:flutter/widgets.dart';

class AppLocalization {

  AppLocalization(this.locale);

  final Locale locale;

  static AppLocalization of(BuildContext context) {
    return Localizations.of(context, AppLocalization);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title':'Home page(en)',
      'button':'GO TO 2nd SCREEN(en)',
    },
    'de': {
      'title':'Home page(de)',
      'button':'GO TO 2nd SCREEN(de)',
    },
    'default': {
      'title':'Home page default',
      'button':'GO TO 2nd SCREEN(default)',
    }
  };

  String get titleText {
    if (_localizedValues.containsKey(locale.languageCode)){
      return _localizedValues[locale.languageCode]!['title']!;
    }
    return _localizedValues['default']!['title']!;
  }

  String get buttonText {
    if (_localizedValues.containsKey(locale.languageCode)){
      return _localizedValues[locale.languageCode]!['button']!;
    }
    return _localizedValues['default']!['button']!;
  }
}