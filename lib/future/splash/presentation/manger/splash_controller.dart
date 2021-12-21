import 'dart:async';
import 'package:get/get.dart';
import 'package:whats_app_clone/future/main/presentation/main_view.dart';

class SplashController extends GetxController {
  final int _seconds = 3;
  
  @override
  void onInit() {
    _timer();
    super.onInit();
  }

  _timer() {
    Timer(Duration(seconds: _seconds), ()=> Get.offAll(() => MainView()));
    update();
  }
}
