export 'widgets/custom_input.dart';
export 'widgets/custom_text.dart';
export 'widgets/custom_spacing.dart';
export 'widgets/custom_button.dart';
export 'util/constant.dart';
export 'services/notifications/notifications.dart';
export 'util/binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/locale/translation.dart';
import '../config/routes/app_pages.dart';
import '../config/themes/theme_services.dart';
import '../config/themes/themes.dart';
import 'services/locale/locale_services.dart';

class CustomWidgets {
  static bool get isRTL => LanguageService().isRTL;

  static void snackBar(content, duration) =>
      ScaffoldMessenger.of(Get.context!).showSnackBar(snack(content, duration));

  static SnackBar snack(content, duration) => SnackBar(
        content: Container(
          height: Get.height * .1,
          alignment: Alignment.center,
          child: content,
        ),
        duration: Duration(seconds: duration),
        backgroundColor: Colors.blueGrey,
      );


  static ThemeData get darkTheme => Themes.dark;
  static ThemeData get lightTheme => Themes.light;
  static ThemeMode get theme => ThemeService().theme;


  static String get initialRoute => AppPages.initial;

  static List<GetPage<dynamic>> get routes => AppPages.routes;

  static Translation get translations => Translation();
  static Locale get locale => LanguageService().locale;


}
