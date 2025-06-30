import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_colors.dart';
import 'package:news_app/core/constants/app_fonts.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry? padding;

  const AppText(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.align,
    this.maxLines,
    this.overflow,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        textAlign: align,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontFamily: AppFonts.SFPro,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ?? AppColors.black,
        ),
      ),
    );
  }
}
