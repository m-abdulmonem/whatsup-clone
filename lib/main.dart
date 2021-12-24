import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'core/lib/custom_widgets.dart';
import 'package:get/get.dart';

List<CameraDescription> cameras = [];

void main() async{
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
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