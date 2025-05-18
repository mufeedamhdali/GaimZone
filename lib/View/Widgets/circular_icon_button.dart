import 'package:flutter/material.dart';
import 'package:gaimzone/utils/colors.dart';

class CircularIcon extends StatelessWidget {
  final String icon;
  final double? padding;
  final double? size;

  const CircularIcon({
    required this.icon,
    this.padding,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: size ?? 40,
      height: size ?? 40,
      padding: EdgeInsets.all(padding ?? 10),
      decoration: const BoxDecoration(
        color: lightGrey,
        shape: BoxShape.circle,
      ),
      child: Image.asset(icon),
    );
  }
}
