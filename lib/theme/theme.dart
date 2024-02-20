import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer_vibes/app_color.dart';
import 'package:volunteer_vibes/theme/elevated_btn_theme.dart';
import 'package:volunteer_vibes/theme/input_theme.dart';
import 'package:volunteer_vibes/theme/text_theme.dart';

class HAppTheme {
  HAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.ptSans().fontFamily,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: AppColors.lightbackColor,
    textTheme: HTextTheme.lightTextTheme,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
    elevatedButtonTheme: ElevatedButtonThemeData(),
    inputDecorationTheme: HInputTheme.inputTheme,
    
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: GoogleFonts.ptSans().fontFamily,
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: AppColors.darkBackColor,
    textTheme: HTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(backgroundColor: Colors.blue),
    elevatedButtonTheme: HelevatedBtnTheme.lightElevatedBtnTheme,
    inputDecorationTheme: HInputTheme.inputTheme,
  );
}
