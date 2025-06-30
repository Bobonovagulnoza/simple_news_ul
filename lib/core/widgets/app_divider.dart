import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double height;
  final Color? color;

  const AppDivider({super.key, this.height = 1, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color ?? Colors.grey.shade300,
      thickness: height,
    );
  }
}
