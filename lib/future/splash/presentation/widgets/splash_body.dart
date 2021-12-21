import 'package:whats_app_clone/core/lib/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            "assets/images/logo/logo.png",
            width: Get.width * .5,
          ),
          Spacer(),
          Padding(
              padding: EdgeInsets.only(bottom: Get.height * .1),
              child: Column(
                children: [
                  CustomText(
                    "from",
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                  VerticalSpace(15),
                  CustomText(
                    "Facebook",
                    fontSize: 21,
                    color: colorLight,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
