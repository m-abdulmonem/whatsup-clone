import 'package:flutter/material.dart';
import 'core/lib/custom_widgets.dart';
import 'package:get/get.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialBinding: Binding(),
      theme:  CustomWidgets.lightTheme,
      darkTheme: CustomWidgets.darkTheme,
      initialRoute: CustomWidgets.initialRoute,
      getPages: CustomWidgets.routes,
      themeMode: CustomWidgets.theme,
      translations: CustomWidgets.translations,
      locale: CustomWidgets.locale,
      fallbackLocale: Get.deviceLocale,
    );
  }
}