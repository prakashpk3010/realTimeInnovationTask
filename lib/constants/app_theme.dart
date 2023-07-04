import 'package:flutter/material.dart';
import 'package:realtime_task/constants/app_colors.dart';

///Custom appTheme
class AppTheme {
  final ThemeData customTheme = ThemeData(
    iconTheme: IconThemeData(color: AppColors().primaryColor),
    scaffoldBackgroundColor: AppColors().scaffColor,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
    ),
  );
}
