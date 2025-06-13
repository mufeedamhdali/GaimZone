import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class CollapsedView extends StatefulWidget {
  final String auctionStatus;
  final bool isLoading;
  final CountDownController countDownController;

  const CollapsedView(
      {super.key,
      required this.auctionStatus,
      required this.isLoading,
      required this.countDownController});

  @override
  State<CollapsedView> createState() => _CollapsedViewState();
}

class _CollapsedViewState extends State<CollapsedView> {
  bool isPlayerSold = false;
  bool isBidEnabled = true;

  final List<String> imageUrls = [
    AppImages.sliderImage,
    AppImages.sliderImage,
    AppImages.sliderImage,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceTint,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 0),
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(
                width: 2,
              ),
              Container(
                width: Dimensions.collapsedCircleWidth(context),
                height: Dimensions.collapsedCircleWidth(context),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: timeTicker(Colors.transparent),
              ),
              Container(
                height: Dimensions.collapsedCircleWidth(context) * 1.1,
                width: Dimensions.collapsedCircleWidth(context) * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    playerImageViewSmall(),
                    (widget.auctionStatus == "live" && !isPlayerSold)
                        ? Container()
                        : Opacity(
                            opacity:
                                widget.auctionStatus == "paused" ? .45 : .75,
                            child: Container(
                              width: Dimensions.collapsedCircleWidth(context),
                              height: Dimensions.collapsedCircleWidth(context),
                              decoration: BoxDecoration(
                                color: widget.auctionStatus == "paused"
                                    ? Theme.of(context).colorScheme.error
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryFixed,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                    (!isPlayerSold)
                        ? Container()
                        : const Text(
                            "SOLD",
                            style: TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
              Container(
                  height: Dimensions.collapsedCircleWidth(context),
                  width: Dimensions.collapsedCircleWidth(context),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blackColor,
                  ),
                  child: pointsViewSmall(
                    SvgPicture.asset(AppImages.leagueIcon),
                    Text(
                      "Mapple",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondaryFixed,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Container(
                  height: Dimensions.collapsedCircleWidth(context),
                  width: Dimensions.collapsedCircleWidth(context),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blackColor,
                  ),
                  child: pointsViewSmall(
                    const Text(
                      "Points",
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 9),
                    ),
                    widget.isLoading
                        ? CustomShimmer.shimmerDefault(context,
                            width: 20, height: 16)
                        : Text(
                            widget.auctionStatus == "live" ? "2000" : "----",
                            style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                  )),
              const SizedBox(
                width: 2,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Gurup Wamsi Kumar(Guru)",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Theme.of(context).colorScheme.surfaceDim),
          ),
          InkWell(
            onTap: () {
              if (isBidEnabled) {
                const options = ConfettiOptions(
                    spread: 360,
                    ticks: 50,
                    gravity: 0,
                    decay: 0.4,
                    startVelocity: 30,
                    y: 0.2,
                    x: .4,
                    colors: [
                      Color(0xffFFE400),
                      Color(0xffFFBD00),
                      Color(0xffE89400),
                      Color(0xffFFCA6C),
                      Color(0xffFDFFB8)
                    ]);

                shoot() {
                  Confetti.launch(context,
                      options: options.copyWith(
                          particleCount: 40,
                          scalar: 1.2,
                          colors: defaultColors),
                      particleBuilder: (index) => Square());
                }

                Timer(Duration.zero, shoot);
                Timer(const Duration(milliseconds: 100), shoot);
                Timer(const Duration(milliseconds: 200), shoot);
              }
              setState(() {
                isBidEnabled = !isBidEnabled;
                isPlayerSold = !isPlayerSold;
                if (!isBidEnabled) {
                  isPlayerSold = true;
                }
              });
            },
            child: Opacity(
              opacity: isBidEnabled ? 1.0 : .2,
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                margin: const EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(30)),
                alignment: Alignment.center,
                width: Dimensions.screenWidth(context) * .7,
                child: widget.isLoading
                    ? CustomShimmer.shimmerDefault(context,
                        width: 70, height: 30)
                    : const Text(
                        "Bid - 2000",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteColor),
                      ),
              ),
            ),
          ),
          Container(
            width: Dimensions.screenWidth(context) * .74,
            padding: const EdgeInsets.only(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Lufga',
                          color: Theme.of(context).colorScheme.surfaceDim,
                        ),
                        children: const [
                          TextSpan(text: "My Balance"),
                          TextSpan(
                              text: "\n5000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ])),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lufga',
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.surfaceDim,
                        ),
                        children: const [
                          TextSpan(text: "Max Bid Points"),
                          TextSpan(
                              text: "\n2000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ])),
                RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Lufga',
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.surfaceDim,
                        ),
                        children: const [
                          TextSpan(text: "My Players"),
                          TextSpan(
                              text: "\n5/10",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15)),
                        ])),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget timeTicker(Color backgroundColor) {
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
              controller: widget.countDownController,
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

  Widget playerImageViewSmall() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.13,
              child: Container(
                width: Dimensions.collapsedCircleWidth(context) * 1.1,
                height: Dimensions.collapsedCircleWidth(context) * 1.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Opacity(
              opacity: 0.13,
              child: Container(
                width: Dimensions.collapsedCircleWidth(context),
                height: Dimensions.collapsedCircleWidth(context),
                decoration: const BoxDecoration(
                  color: AppColors.blackColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Opacity(
              opacity: .36,
              child: Container(
                width: Dimensions.collapsedCircleWidth(context) * .9,
                height: Dimensions.collapsedCircleWidth(context) * .9,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              width: Dimensions.collapsedCircleWidth(context) * .8,
              height: Dimensions.collapsedCircleWidth(context) * .8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Image.asset(
                  AppImages.playerImage,
                ),
              ),
            ),
          ],
        ));
  }

  Widget pointsViewSmall(Widget topWidget, Widget bottomWidget) {
    return Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: Dimensions.collapsedCircleWidth(context),
              height: Dimensions.collapsedCircleWidth(context),
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: Dimensions.collapsedCircleWidth(context) * .8,
              height: Dimensions.collapsedCircleWidth(context) * .8,
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.brightYellow,
                  width: .5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    topWidget,
                    bottomWidget,
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
