import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/locale/locale_services.dart';

class CustomText extends StatelessWidget {
  final String data;
  final Color? color;
  final double? fontSize,width;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  const CustomText(this.data,
      {Key? key,
      this.color = const Color(0xff000000),
      this.fontSize = 14,
      this.fontWeight = FontWeight.w100,
      this.textAlign, this.width, this.onTap, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  Container(
        padding: padding,
        width: width,
        child: Text(
          data,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: fontSize,
            color: Get.isDarkMode ? Colors.white : color,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
          textDirection: TextDirection.rtl,
          textAlign: textAlign ?? (LanguageService().isRTL ? TextAlign.right : TextAlign.left),
        ),
      ),
    );
  }
}
