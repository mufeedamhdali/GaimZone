import 'dart:core';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class CustomTimeTicker extends StatelessWidget {
  final Color backgroundColor;
  final CountDownController countDownController;

  const CustomTimeTicker({
    super.key,
    required this.backgroundColor,
    required this.countDownController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          width: Dimensions.largeCircleWidth(context) * .8,
          height: Dimensions.largeCircleWidth(context) * .8,
        ),
        Stack(
          children: [
            CircularCountDownTimer(
              duration: 60,
              initialDuration: 0,
              controller: countDownController,
              width: Dimensions.largeCircleWidth(context) * .6,
              height: Dimensions.largeCircleWidth(context) * .6,
              ringColor: AppColors.darkGrey,
              fillColor: Theme.of(context).colorScheme.tertiary,
              backgroundColor: backgroundColor,
              strokeWidth: 5,
              strokeCap: StrokeCap.square,
              textStyle: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.surfaceDim,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.S,
              isTimerTextShown: true,
              isReverseAnimation: true,
              isReverse: true,
              autoStart: true,
            ),
            Positioned(
              top: Dimensions.largeCircleWidth(context) * .35,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: Dimensions.largeCircleWidth(context) * .6,
                height: 16,
                color: Colors.transparent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Sec",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
