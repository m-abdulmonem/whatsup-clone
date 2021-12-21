import 'package:flutter/material.dart';
import 'widgets/splash_body.dart';
import 'manger/splash_controller.dart';
import 'package:get/get.dart';

class SplashView extends GetWidget<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashBody(),
    );
  }
}
