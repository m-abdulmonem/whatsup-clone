import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService {
  final _storage = GetStorage();
  final _key = 'Locale';

  Locale get locale =>Locale( _loadLocale());

  bool get isRTL => locale.toString() == "ar";

  String _loadLocale() =>
      _storage.read(_key) ?? Get.deviceLocale.toString().split("_")[0];

  void _saveLocale(String locale) => _storage.write(_key, locale);

  void switchLocale(String locale) {
    Get.updateLocale(Locale(locale));
    _saveLocale(locale);
  }
}
