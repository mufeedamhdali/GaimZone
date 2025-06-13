import 'dart:core';

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class CustomButton extends StatelessWidget {
  final bool? visibility;
  final Function()? onTap;
  final String? label;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? borderRadius;
  final double? width;
  final double? height;
  final TextStyle? labelStyle;
  final Border? border;

  const CustomButton({
    super.key,
    this.visibility,
    this.onTap,
    this.label,
    this.padding,
    this.margin,
    this.color,
    this.borderRadius,
    this.width,
    this.height,
    this.labelStyle,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Visibility(
        visible: visibility ?? true,
        child: Container(
          padding: padding ?? const EdgeInsets.only(top: 10, bottom: 10),
          margin: margin ?? const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              border: border ?? const Border(top: BorderSide.none,bottom: BorderSide.none,left: BorderSide.none,right: BorderSide.none,),
              color: color ?? Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(borderRadius ?? 30)),
          alignment: Alignment.center,
          width: width ?? Dimensions.screenWidth(context) * .7,
          height: height ?? 50,
          child: Text(
            label ?? "",
            style: labelStyle ??
                const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}
