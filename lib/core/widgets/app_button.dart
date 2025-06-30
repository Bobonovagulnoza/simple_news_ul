import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color color;
  final Color textColor;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.width,
    this.height = 48,
    this.borderRadius = 30,
    this.color = AppColors.black,
    this.textColor = AppColors.white,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
