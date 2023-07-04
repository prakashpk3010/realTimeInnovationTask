import 'package:flutter/material.dart';
import 'package:realtime_task/constants/app_colors.dart';
import 'package:realtime_task/constants/app_font_style.dart';
import 'package:realtime_task/constants/app_layouts.dart';

class CustomTextfield extends StatelessWidget {
  final Widget? suficon;
  final VoidCallback? ontap;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? preIcon;
  final bool? readOnly;

  const CustomTextfield(
      {super.key,
      this.suficon,
      required this.hint,
      required this.controller,
      this.validator,
      this.preIcon,
      this.ontap,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        readOnly: readOnly!,
        onTap: ontap,
        style: AppFontStyles().textFieldStyle,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          hintStyle: AppFontStyles().textFieldStyle,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors().textFieldCol, width: 0.2),
              borderRadius: BorderRadius.circular(
                Applayout().textFieldRadius,
              )),
          border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: AppColors().textFieldCol, width: 0.2),
              borderRadius: BorderRadius.circular(
                Applayout().textFieldRadius,
              )),
          suffixIconColor: AppColors().primaryColor,
          prefixIconColor: AppColors().primaryColor,
          suffixIcon: suficon,
          prefixIcon: preIcon,
          hintText: hint,
        ),
      ),
    );
  }
}
