import 'package:flutter/material.dart';

extension GapExtension on num {
  /// Misol: 16.g - bu avtomatik o'lcham beradi
  Widget get g => Gap(toDouble());
}

class Gap extends StatelessWidget {
  final double size;

  const Gap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    // Ota widget qaysi Flex (Row yoki Column) ekanini aniqlaymiz
    final Flex? parentFlex = context.findAncestorWidgetOfExactType<Flex>();

    if (parentFlex != null) {
      if (parentFlex.direction == Axis.horizontal) {
        // Agar Row (Axis.horizontal) ichida bo'lsa, width ni beramiz
        return SizedBox(width: size);
      } else {
        // Agar Column (Axis.vertical) ichida bo'lsa, height ni beramiz
        return SizedBox(height: size);
      }
    } else {
      // Agar ota widget Flex bo'lmasa (masalan, oddiy Container ichida bo'lsa), default vertical bo'sh joy
      return SizedBox(height: size);
    }
  }
}
