import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'images.dart';

class Dimensions {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static const double appBarHeight = 60;
  static const double backgroundHeight = 660;
  static const double topPadding = 57;

  static SizedBox verticalSpace(double space) => SizedBox(height: space);
  static SizedBox horizontalSpace(double space) => SizedBox(width: space);

  static double largeCircleWidth(BuildContext context) =>
      Dimensions.screenWidth(context) * 0.22;

  static double curveWith(BuildContext context) =>
      largeCircleWidth(context) * .7;

  static double collapsedCircleWidth(BuildContext context) =>
      Dimensions.screenWidth(context) * .18;
}

class AppState {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static String getAuctionStatus(String status) {
    Map<String, String> getStringStatus = {
      "live": "Live",
      "stopped": "Stopped",
      "closed": "Stopped",
      "paused": "Paused"
    };
    return getStringStatus[status] ?? "";
  }

  static List<String> imageUrls() {
    final List<String> imageUrls = [
      AppImages.sliderImage,
      AppImages.sliderImage,
      AppImages.sliderImage,
    ];
    return imageUrls;
  }
}

class CustomShimmer {
  static Widget shimmerImage(BuildContext context,
      {double? height, double? width}) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceDim.withOpacity(.2),
      highlightColor: Theme.of(context).colorScheme.surfaceDim.withOpacity(.4),
      child: Container(
          decoration:
              const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          margin: const EdgeInsets.all(1),
          height: height,
          width: width),
    );
  }

  static Widget shimmerDefault(BuildContext context,
      {double? height, double? width, Color? color, double? radius}) {
    return Shimmer.fromColors(
      baseColor: color?.withOpacity(.2) ??
          Theme.of(context).colorScheme.surfaceDim.withOpacity(.2),
      highlightColor: color?.withOpacity(.2) ??
          Theme.of(context).colorScheme.surfaceDim.withOpacity(.4),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(radius ?? 5)),
          margin: const EdgeInsets.all(1),
          height: height,
          width: width),
    );
  }
}

