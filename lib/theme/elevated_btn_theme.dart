import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:volunteer_vibes/app_color.dart';

class HelevatedBtnTheme {
  HelevatedBtnTheme._();

  static ElevatedButtonThemeData lightElevatedBtnTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primary,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.kenia().fontFamily),
    ),
  );
}
