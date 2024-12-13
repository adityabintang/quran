import 'package:flutter/material.dart';

import '../utils/color.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final double? height;
  const TextFieldContainer({
    super.key,
    this.child,
    this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      width: MediaQuery.of(context).size.width,
      height: height ?? 50,
      decoration: BoxDecoration(
        color: color ?? MyColors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    );
  }
}