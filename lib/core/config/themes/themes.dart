import 'package:flutter/material.dart';
import '../../lib/custom_widgets.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      // radioTheme: RadioThemeData(
      //   overlayColor: MaterialStateColor.resolveWith((states) => Colors.blue),
      //   fillColor: MaterialStateColor.resolveWith((states) => colorPrimary),
      //
      // ),

      appBarTheme: const AppBarTheme(
          backgroundColor: colorSecondary,
          elevation: 5,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
              color: colorPrimary, fontWeight: FontWeight.bold, fontSize: 19)));

  static final dark = ThemeData.dark().copyWith(
    appBarTheme: const AppBarTheme(
      backgroundColor: colorPrimaryDark,
      elevation: 5,
    ),
    backgroundColor: Colors.black,
    primaryColor: Colors.black45,
    textTheme: const TextTheme().copyWith(),
    primaryTextTheme: TextTheme().copyWith(),
  );
}
