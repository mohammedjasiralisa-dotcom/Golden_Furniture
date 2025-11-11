import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _languageCode = 'en';

  String get languageCode => _languageCode;

  void setLanguage(String code) {
    if (code != _languageCode) {
      _languageCode = code;
      notifyListeners();
    }
  }

  bool isTamil() => _languageCode == 'ta';
  bool isEnglish() => _languageCode == 'en';
}
