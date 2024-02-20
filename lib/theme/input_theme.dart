import 'package:flutter/material.dart';
import 'package:volunteer_vibes/app_color.dart';

var textColor = Colors.black;
var errorColor = Colors.red;
var primaryColor = Colors.blue;
var dividerColor = Colors.blueGrey;
var disabledColor = Colors.grey;

class HInputTheme {
  HInputTheme._();

  static InputDecorationTheme inputTheme = InputDecorationTheme(
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: errorColor),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2.0, color: primaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: dividerColor),
      borderRadius: BorderRadius.circular(10),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: dividerColor),
      borderRadius: BorderRadius.circular(10),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 0.5, color: disabledColor),
      borderRadius: BorderRadius.circular(10),
    ),
    floatingLabelStyle:
        const TextStyle(color: AppColors.primary, fontSize: 18.0),
  );
}
