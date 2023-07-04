import 'package:flutter/material.dart';
import 'package:realtime_task/constants/app_colors.dart';

class CustomButtons extends StatelessWidget {
  final VoidCallback function;
  final String text;
  final bool isSelected;
  final double width;
  const CustomButtons({
    super.key,
    required this.function,
    required this.text,
    required this.isSelected,
    this.width = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: function,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 150,
          ),
          width: width,
          child: Card(
            elevation: 0,
            color: isSelected ? AppColors().primaryColor : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 13,
                    color:
                        !isSelected ? AppColors().primaryColor : Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
