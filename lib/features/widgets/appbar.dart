import 'package:flutter/material.dart';
import 'package:realtime_task/constants/app_font_style.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppFontStyles().appbarTitle,
      ),
    );
  }
}
