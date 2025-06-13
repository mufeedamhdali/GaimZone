import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class ExpandedView extends StatefulWidget {
  final String auctionStatus;
  final bool isLoading;
  final VoidCallback pauseAutoScroll;
  final VoidCallback resumeAutoScroll;
  final VoidCallback stopAutoScroll;
  final ScrollController sliderScrollController;
  final CountDownController countDownController;

  const ExpandedView(
      {super.key,
      required this.auctionStatus,
      required this.sliderScrollController,
      required this.countDownController,
      required this.isLoading,
      required this.stopAutoScroll,
      required this.resumeAutoScroll,
      required this.pauseAutoScroll});

  @override
  State<ExpandedView> createState() => _ExpandedViewState();
}

class _ExpandedViewState extends State<ExpandedView> {
  bool isPlayerSold = false;
  bool isBidEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: Dimensions.appBarHeight() +
              Dimensions.screenHeight(context) * .06,
          width: Dimensions.screenWidth(context),
          color: Theme.of(context).colorScheme.primary,
        ),
        Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: widget.auctionStatus == "closed" ? 500 : 400,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      widget.auctionStatus == "closed"
                          ? Positioned(
                              top: 110,
                              child: pausedView(),
                            )
                          : Positioned(
                              top: 50,
                              child: widget.isLoading
                                  ? CustomShimmer.shimmerImage(context,
                                      height:
                                          Dimensions.screenWidth(context) * .7,
                                      width:
                                          Dimensions.screenWidth(context) * .7)
                                  : playerImageView()),
                      widget.auctionStatus == "closed"
                          ? Container()
                          : Positioned(bottom: 0, child: pointDetailsView()),
                      widget.auctionStatus == "closed"
                          ? Container()
                          : widget.isLoading
                              ? Container()
                              : Positioned(
                                  top: Dimensions.screenWidth(context) * .5,
                                  right: Dimensions.screenWidth(context) * .16,
                                  child: SvgPicture.asset(
                                    AppImages.bookmarkBadge,
                                    width:
                                        Dimensions.screenWidth(context) * .12,
                                  ),
                                ),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.auctionStatus == "paused",
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.transparent,
                    child: const Text(
                      "PAUSED",
                      style: TextStyle(
                          fontSize: 50,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Visibility(
                  visible: isPlayerSold && widget.auctionStatus == "live",
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        color: Colors.transparent,
                        child: const Text(
                          "SOLD",
                          style: TextStyle(
                              fontSize: 50,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppState.isDarkMode(context)
                                  ? DarkColors.highlightYellow
                                  : LightColors.highlightYellow,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                AppImages.mapleLogo,
                                width: 20,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Mapple",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Visibility(
                  visible: widget.auctionStatus == "stopped",
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(20),
                    width: Dimensions.screenWidth(context) * .6,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(50)),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Stopped by league owner, Will be ",
                          ),
                          TextSpan(
                              text: "resumed ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: "on "),
                          TextSpan(
                              text: "June 10, 9:41am",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                        style: TextStyle(
                            fontFamily: 'Lufga',
                            fontSize: 14,
                            color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),
                  width: Dimensions.screenWidth(context),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 0, bottom: 10),
                  child: playersSummary(),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    width: Dimensions.curveWith(context) +
                        Dimensions.largeCircleWidth(context) +
                        Dimensions.curveWith(context),
                    height: Dimensions.largeCircleWidth(context) / 2,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          left: Dimensions.curveWith(context),
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    Dimensions.largeCircleWidth(context) / 2),
                                topRight: Radius.circular(
                                    Dimensions.largeCircleWidth(context) / 2),
                              ),
                            ),
                            width: Dimensions.largeCircleWidth(context),
                            height: Dimensions.largeCircleWidth(context) / 2,
                          ),
                        ),
                        Positioned(
                          bottom: -12,
                          right: Dimensions.curveWith(context) +
                              Dimensions.largeCircleWidth(context) -
                              15,
                          child: Transform(
                            transform: Matrix4.identity()..scale(-1.0, 1.0),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppImages.rightCurve,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.surface,
                                BlendMode.srcIn,
                              ),
                              width: Dimensions.curveWith(context),
                              height: Dimensions.largeCircleWidth(context) * .5,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: -12,
                            left: Dimensions.curveWith(context) +
                                Dimensions.largeCircleWidth(context) -
                                15,
                            child: SvgPicture.asset(
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.surface,
                                BlendMode.srcIn,
                              ),
                              height: Dimensions.largeCircleWidth(context) * .5,
                              AppImages.rightCurve,
                              width: Dimensions.curveWith(context),
                              fit: BoxFit.fitWidth,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (widget.auctionStatus == "live" || widget.auctionStatus == "paused")
                ? Positioned(
                    top: 20,
                    left: (Dimensions.screenWidth(context) / 2) -
                        (Dimensions.largeCircleWidth(context) * .9 / 2),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          width: Dimensions.largeCircleWidth(context) * .9,
                          height: Dimensions.largeCircleWidth(context) * .9,
                        ),
                        timeTicker(Theme.of(context).colorScheme.surface),
                      ],
                    ))
                : Positioned(
                    top: 30,
                    left: Dimensions.screenWidth(context) / 4,
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            AppImages.bellIcon,
                            width: 10,
                            height: 10,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 20, right: 20),
                          margin: const EdgeInsets.only(top: 0, bottom: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          width: Dimensions.screenWidth(context) * .5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "10 June",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.whiteColor),
                              ),
                              Countdown(
                                seconds: 1000,
                                build: (_, double time) {
                                  int hours = (time / 3600).floor();
                                  int minutes = ((time % 3600) / 60).floor();
                                  int seconds = (time % 60).floor();

                                  return Text(
                                    "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.whiteColor),
                                  );
                                },
                                onFinished: () => {},
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
          ],
        ),
        widget.auctionStatus == "closed"
            ? Container()
            : Stack(
                children: [
                  Container(
                    height: 240,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary),
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40))),
                    child: currentBalanceSummary(),
                  ),
                  InkWell(
                    onTap: () {
                      if (isBidEnabled) {
                        const options = ConfettiOptions(
                            spread: 360,
                            ticks: 100,
                            gravity: 0,
                            decay: 0.7,
                            startVelocity: 30,
                            y: 0.4,
                            x: .5,
                            particleCount: 80,
                            scalar: 1.2,
                            colors: defaultColors);

                        shoot() {
                          Confetti.launch(context,
                              options: options,
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
                    child: Container(
                      height: 200,
                      padding: const EdgeInsets.all(4),
                      alignment: Alignment.bottomCenter,
                      width: Dimensions.screenWidth(context),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceTint,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(40),
                              bottomLeft: Radius.circular(40))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Opacity(
                            opacity: isBidEnabled ? 1.0 : .2,
                            child: Container(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              width: Dimensions.screenWidth(context) * .8,
                              child: widget.isLoading
                                  ? CustomShimmer.shimmerDefault(context,
                                      width: 70, height: 20)
                                  : const Text(
                                      "Bid - 2000",
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          widget.isLoading
                              ? CustomShimmer.shimmerDefault(context,
                                  height: 20,
                                  width: Dimensions.screenWidth(context) * .5)
                              : RichText(
                                  text: TextSpan(
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                    children: [
                                      TextSpan(
                                          text: 'Max bid point: ',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surfaceDim)),
                                      const TextSpan(
                                        text: '5000',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 15, right: 15, top: 0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(40),
                            bottomLeft: Radius.circular(40))),
                    child: playerDetails(),
                  ),
                ],
              ),
      ],
    );
  }

  Widget topSection() {
    return SizedBox(
      width: Dimensions.screenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.isLoading
              ? CustomShimmer.shimmerImage(context,
                  height: Dimensions.screenWidth(context) * .1,
                  width: Dimensions.screenWidth(context) * .1)
              : Stack(
                  children: [
                    Image.asset(
                      AppImages.playerDefaultImage,
                      height: Dimensions.screenWidth(context) * .1,
                      width: Dimensions.screenWidth(context) * .1,
                    ),
                    Positioned(
                      right: 02,
                      top: 02,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceBright,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                      ),
                    ),
                  ],
                ),
          widget.isLoading
              ? CustomShimmer.shimmerDefault(context,
                  height: 18, width: Dimensions.screenWidth(context) * .6)
              : const Text(
                  "Mapple Premier League",
                  style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
          Container(
            padding:
                const EdgeInsets.only(top: 5, left: 12, right: 12, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: widget.auctionStatus == "live"
                      ? Theme.of(context).colorScheme.surfaceBright
                      : Theme.of(context).colorScheme.error,
                  width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: widget.isLoading
                ? CustomShimmer.shimmerDefault(context, height: 15, width: 30)
                : Text(
                    AppState.getAuctionStatus(widget.auctionStatus),
                    style: TextStyle(
                        color: widget.auctionStatus == "live"
                            ? Theme.of(context).colorScheme.surfaceBright
                            : Theme.of(context).colorScheme.error,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
          )
        ],
      ),
    );
  }

  Widget playersSummary() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            playersInfoCard("200", "Total Players"),
            playersInfoCard("130", "Sold Players"),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            playersInfoCard("67", "Total Players"),
            playersInfoCard("3", "Unsold Players"),
          ],
        )
      ],
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

  Widget playerImageView() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: Dimensions.screenWidth(context) * .76,
              height: Dimensions.screenWidth(context) * .76,
              decoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary10,
                  width: 1,
                ),
              ),
            ),
            Container(
              width: Dimensions.screenWidth(context) * .69,
              height: Dimensions.screenWidth(context) * .69,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary36,
                  width: 25,
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  width: Dimensions.screenWidth(context) * .6,
                  height: Dimensions.screenWidth(context) * .6,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(AppImages.playerImage),
                  ),
                ),
                (widget.auctionStatus == "live" && !isPlayerSold)
                    ? Container()
                    : Opacity(
                        opacity: widget.auctionStatus == "paused" ? .45 : .75,
                        child: Container(
                          width: Dimensions.screenWidth(context) * .6,
                          height: Dimensions.screenWidth(context) * .6,
                          decoration: BoxDecoration(
                            color: widget.auctionStatus == "paused"
                                ? Theme.of(context).colorScheme.error
                                : Theme.of(context).colorScheme.primaryFixed,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ));
  }

  Widget pointDetailsView() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: Dimensions.screenWidth(context) * .3,
              height: Dimensions.screenWidth(context) * .3,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.brightYellow,
                  width: .5,
                ),
              ),
            ),
            Container(
              width: Dimensions.screenWidth(context) * .25,
              height: Dimensions.screenWidth(context) * .25,
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: Dimensions.screenWidth(context) * .21,
              height: Dimensions.screenWidth(context) * .21,
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.brightYellow,
                  width: .5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Points",
                      style:
                          TextStyle(color: AppColors.whiteColor, fontSize: 13),
                    ),
                    widget.isLoading
                        ? CustomShimmer.shimmerDefault(context, height: 16)
                        : Text(
                            widget.auctionStatus == "live" ? "2000" : "----",
                            style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget playerDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.isLoading
            ? CustomShimmer.shimmerDefault(context,
                height: 18, width: Dimensions.screenWidth(context) * .7)
            : Text(
                "Gurup Wamsi Kumar(Guru)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.surfaceDim),
              ),
        widget.isLoading
            ? CustomShimmer.shimmerDefault(context,
                height: 18, width: Dimensions.screenWidth(context) * .5)
            : RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.surfaceDim),
                  children: [
                    const TextSpan(text: '32y old, '),
                    TextSpan(
                      text: 'Striker',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.surfaceDim,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
        widget.isLoading
            ? CustomShimmer.shimmerDefault(context, height: 20)
            : Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                width: Dimensions.screenWidth(context),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        infoCard("Wicketkeeper", "25"),
                        infoCard("Bowler", "12"),
                        infoCard("All-rounder", "13"),
                        infoCard("Finisher", "2"),
                      ],
                    ),
                  ),
                ),
              )
      ],
    );
  }

  Widget currentBalanceSummary() {
    return Container(
      width: Dimensions.screenWidth(context),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isLoading
              ? CustomShimmer.shimmerDefault(context,
                  height: 18, width: Dimensions.screenWidth(context) * .3)
              : RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.surfaceDim),
                    children: const [
                      TextSpan(text: 'My balance: '),
                      TextSpan(
                        text: '1800',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
          widget.isLoading
              ? CustomShimmer.shimmerDefault(context,
                  height: 18, width: Dimensions.screenWidth(context) * .3)
              : RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyLarge?.apply(
                        color: Theme.of(context).colorScheme.surfaceDim),
                    children: const [
                      TextSpan(text: 'My players: '),
                      TextSpan(
                        text: '5/10',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget playersInfoCard(String count, String label) {
    return widget.isLoading
        ? CustomShimmer.shimmerDefault(context,
            height: 15, width: Dimensions.screenWidth(context) * .2)
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                count,
                style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 13,
                    fontWeight: FontWeight.normal),
              ),
            ],
          );
  }

  Widget infoCard(String label, String count) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 8, right: 8),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).colorScheme.primaryFixed),
            margin: const EdgeInsets.only(
              left: 2,
            ),
            padding:
                const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 8),
            child: Text(
              label,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surface, fontSize: 13),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: AppColors.lightPurple10,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              count,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget pausedView() {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            width: Dimensions.screenWidth(context) * .9,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                    color: Theme.of(context).colorScheme.surfaceTint),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Remaining players : 30",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Bookmarked ",
                        style: TextStyle(
                            fontSize: 11,
                            color: AppState.isDarkMode(context)
                                ? DarkColors.gray002
                                : LightColors.gray002)),
                    SizedBox(
                      height: 20,
                      child: Switch(
                        inactiveThumbColor: AppColors.darkGrey.withOpacity(.5),
                        trackOutlineColor:
                            WidgetStateProperty.resolveWith<Color?>(
                          (states) {
                            if (states.contains(WidgetState.selected)) {
                              return null;
                            }
                            return AppColors.darkGrey.withOpacity(.5);
                          },
                        ),
                        activeColor: AppColors.outlineDark,
                        value: false,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ],
            )),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 240,
          width: Dimensions.screenWidth(context),
          child: GestureDetector(
            onPanDown: (_) => widget.stopAutoScroll,
            onLongPress: widget.pauseAutoScroll,
            onLongPressUp: widget.resumeAutoScroll,
            child: ListView.builder(
              controller: widget.sliderScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: AppState.imageUrls().length * 2,
              itemBuilder: (context, index) {
                return index == 0
                    ? Container(
                        margin: const EdgeInsets.only(
                            left: 35, right: 5, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Theme.of(context).colorScheme.surfaceTint,
                        ),
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  AppState.imageUrls()[0],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Title",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Sub Title",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(5),
                        height: 240,
                        width: MediaQuery.of(context).size.width * .35,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surfaceTint,
                            borderRadius: BorderRadius.circular(150)),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15, bottom: 20),
                                  margin: const EdgeInsets.only(bottom: 0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceTint,
                                      shape: BoxShape.circle),
                                  child: Image.asset(AppImages.playerImage),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: SvgPicture.asset(
                                    AppImages.bookmarkBadge,
                                    width: 40,
                                    height: 40,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Srinath Singh",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              "32 yrs, Striker",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            padding: const EdgeInsets.all(10),
            width: Dimensions.screenWidth(context) * .9,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(10)),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Stopped by league owner, Will be ",
                  ),
                  TextSpan(
                      text: "resumed ",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: "on "),
                  TextSpan(
                      text: "June 10, 9:41am",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
                style: TextStyle(
                    fontFamily: 'Lufga',
                    fontSize: 14,
                    color: AppColors.whiteColor),
              ),
            ))
      ],
    );
  }
}
