import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
import 'package:gaimzone/utils/images.dart';

import 'package:gaimzone/utils/colors.dart';

class AuctionScreen2 extends StatefulWidget {
  const AuctionScreen2({
    super.key,
  });

  @override
  State<AuctionScreen2> createState() => _AuctionScreen2State();
}

class _AuctionScreen2State extends State<AuctionScreen2> {
  bool _passed60Percent = false;

  void _onScrollNotification(ScrollNotification notification) {
    if (notification.metrics.axis == Axis.vertical) {
      final position = notification.metrics.pixels; // current scroll offset
      final maxScroll = notification.metrics.maxScrollExtent; // max possible scroll

      // final isPassed = position > maxScroll * 0.6;
      //
      // if (passed != _passed60Percent) {
      //   setState(() {
      //     _passed60Percent = passed;
      //   });
      // }
      if (position > maxScroll * 0.6) {
        setState(() {
          _passed60Percent = true;
        });
      } else {
        setState(() {
          _passed60Percent = true;
        });
      }
    }
  }

  double screenWidth = 0;
  double screenHeight = 0;
  double titleHeight = 0;
  double backgroundHeight = 0;
  double appBarHeight = 0;
  double largeCircleWidth = 0;
  double curveWith = 0;
  double gapWidth = 0;
  double tabViewHeight = 0;
  double collapsedCircleWidth = 0;
  double topPadding = 0;

  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  setDimension(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    titleHeight = screenHeight * .5;
    backgroundHeight = screenHeight * .75;
    appBarHeight = screenHeight *.07;
    largeCircleWidth = screenWidth * .2;
    curveWith = screenWidth * .11;
    gapWidth = screenWidth * .03;
    tabViewHeight = screenHeight * .6;
    collapsedCircleWidth = screenWidth * .18;
    topPadding = screenHeight * .1;
  }

  @override
  Widget build(BuildContext context) {
    setDimension(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: auctionTopBar(),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          _onScrollNotification(notification);
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            child: Column(
              children: [
                _passed60Percent ? Container(height: 300, color: Colors.green,) : SizedBox(height: 700, child: Container(color: Colors.yellow,)),
                Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                    color: Colors.blue,
                    height: 400,
                    // child: const TabView()
                  )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: _passed60Percent ? Colors.green : Colors.red,
        height: 60,
        child: Center(
          child: Text(
            _passed60Percent ? 'Scrolled > 60%' : 'Below 60%',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        tooltip: 'Options',
        shape: const CircleBorder(),
        mini: true,
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.more_horiz,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   setDimension(context);
  //   return Scaffold(
  //     extendBodyBehindAppBar: true,
  //     backgroundColor: Theme.of(context).colorScheme.surface,
  //     appBar: PreferredSize(
  //       preferredSize: Size.fromHeight(appBarHeight),
  //       child: auctionTopBar(),
  //     ),
  //     body: CustomScrollView(
  //       physics: const BouncingScrollPhysics(),
  //       slivers: [
  //         SliverAppBar(
  //           backgroundColor: Theme.of(context).colorScheme.surface,
  //           floating: true,
  //           pinned: true,
  //           expandedHeight: backgroundHeight,
  //           flexibleSpace: FlexibleSpaceBar(
  //             stretchModes: const [
  //               StretchMode.zoomBackground,
  //             ],
  //             titlePadding: EdgeInsets.zero,
  //             title: collapseLayout(),
  //             background: expandLayout(),
  //           ),
  //         ),
  //         SliverToBoxAdapter(
  //             child: Container(
  //                 padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
  //                 height: tabViewHeight,
  //                 child: const TabView())),
  //       ],
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _onFabPressed,
  //       tooltip: 'Options',
  //       shape: const CircleBorder(),
  //       mini: true,
  //       backgroundColor: Theme.of(context).primaryColor,
  //       child: const Icon(
  //         Icons.more_horiz,
  //         color: AppColors.whiteColor,
  //       ),
  //     ),
  //   );
  // }

  void _onFabPressed() {

  }

  Widget collapseLayout() {
    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double currentHeight = constraints.biggest.height;
            final double collapseProgress =
                (currentHeight - kToolbarHeight) / (titleHeight - kToolbarHeight);
            final bool isExpanded = collapseProgress >= 0.8;
            return Stack(
              children: [
                Positioned(
                  top: appBarHeight,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: isExpanded ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 300),
                    child: collapsedWidget(),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget expandLayout() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double currentHeight = constraints.biggest.height;
        final double collapseProgress =
            (currentHeight - kToolbarHeight) / (titleHeight - kToolbarHeight);
        final bool isCollapsed = collapseProgress <= 0.8;

        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: backgroundHeight + topPadding,
              child: AnimatedOpacity(
                opacity: isCollapsed ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: expandedWidget(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget collapsedWidget() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceTint,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: appBarHeight),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: collapsedCircleWidth,
                height: collapsedCircleWidth,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                ),
                child: timeTicker(Colors.transparent),
              ),
              Container(
                height: collapsedCircleWidth,
                width: collapsedCircleWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: playerImageViewSmall(),
              ),
              Container(
                  height: collapsedCircleWidth,
                  width: collapsedCircleWidth,
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
                  height: collapsedCircleWidth,
                  width: collapsedCircleWidth,
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
                    const Text(
                      "2000",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.center,
            width: screenWidth * .7,
            child: const Text(
              "Bid - 2000",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor),
            ),
          ),
          SizedBox(
            width: screenWidth * .75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.surfaceDim,),
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
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.surfaceDim,),
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
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.surfaceDim,),
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

  Widget expandedWidget() {
    return Column(
      children: [
        // players summary
        Stack(
          children: [
            // rounded container for players summary background
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              height: (screenHeight * .1) + topPadding,
              margin: const EdgeInsets.only(bottom: 5),
            ),

            // players summary data
            Positioned(
              top: (screenHeight * .04)  + topPadding,
              child: playersSummary(),
            ),
          ],
        ),

        // player's image, points details and timer widget are stacked together
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            playerImageView(),
            Positioned(
              top: -40,
              child: Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Center(
                      child: SizedBox(
                        width: screenWidth * .36,
                        height: largeCircleWidth,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: gapWidth - 2,
                              child: SvgPicture.asset(
                                AppImages.leftCurve,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.surface,
                                  BlendMode.srcIn,
                                ),
                                width: curveWith,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Positioned(
                                left: curveWith -
                                    gapWidth +
                                    largeCircleWidth -
                                    gapWidth,
                                top: gapWidth - 1,
                                child: SvgPicture.asset(
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.surface,
                                    BlendMode.srcIn,
                                  ),
                                  AppImages.rightCurve,
                                  width: curveWith,
                                  fit: BoxFit.fitWidth,
                                )),
                            Positioned(
                              left: curveWith - gapWidth,
                              top: gapWidth / 7 - 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                ),
                                width: largeCircleWidth,
                                height: largeCircleWidth,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 40,
                      top: 10,
                      child: timeTicker(Theme.of(context).colorScheme.surface)),
                ],
              ),
            ),
            Positioned(
              top: 190,
              child: pointDetailsView(),
            ),
            Positioned(
              top: 140,
              right: 70,
              child: SvgPicture.asset(
                AppImages.bookmarkBadge,
                width: 45,
              ),
            ),
          ],
        ),

        // bid button and current status of balance and players
        Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                      width: 1, color: Theme.of(context).colorScheme.primary),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
              height: 250,
            ),
            Container(
              height: 205,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
            ),
            Container(
              height: 110,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(40))),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: playerDetails(),
            ),
            Positioned(
              top: 120,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30)),
                    alignment: Alignment.center,
                    width: screenWidth * .8,
                    child: const Text(
                      "Bid - 2000",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyLarge,
                      children:  [
                        TextSpan(text: 'Max bid point: ', style: TextStyle(color: Theme.of(context).colorScheme.surfaceDim)),
                        const TextSpan(
                          text: '5000',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 215,
              child: currentBalanceSummary(),
            ),
          ],
        ),
      ],
    );
  }

  Widget topSection() {
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Stack(
            children: [
              Image.asset(
                AppImages.playerDefaultImage,
                height: screenWidth * .1,
                width: screenWidth * .1,
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
          const Text(
            "Mapple Premier League",
            style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          Container(
            padding:
            const EdgeInsets.only(top: 2, left: 12, right: 12, bottom: 2),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Live',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }

  Widget playersSummary() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
          width: screenWidth,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  playersInfoCard("200", "Total Players"),
                  playersInfoCard("130", "Sold Players"),
                ],
              ),
              Column(
                children: [
                  playersInfoCard("67", "Total Players"),
                  playersInfoCard("3", "Unsold Players"),
                ],
              )
            ],
          ),
        ),
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
          width: screenWidth * .16,
          height: screenWidth * .16,
        ),
        Stack(
          children: [
            CircularCountDownTimer(
              duration: 60,
              initialDuration: 0,
              controller: _controller,
              width: screenWidth * .12,
              height: screenWidth * .12,
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
              top: 32,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: screenWidth * .12,
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
            // Medium circle inside the largest one
            Container(
              width: screenWidth * .76,
              height: screenWidth * .76,
              decoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: .5,
                ),
              ),
            ),
            // Smallest circle inside the medium one
            Container(
              width: screenWidth * .69,
              height: screenWidth * .69,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceTint,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary36,
                  width: 25,
                ),
              ),
            ),
            Container(
              width: screenWidth * .6,
              height: screenWidth * .6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(AppImages.playerImage),
              ),
            ),
          ],
        ));
  }

  Widget playerImageViewSmall() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Medium circle inside the largest one
            Container(
              width: collapsedCircleWidth,
              height: collapsedCircleWidth,
              decoration: const BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
              ),
            ),
            // Smallest circle inside the medium one
            Container(
              width: collapsedCircleWidth * .8,
              height: collapsedCircleWidth * .8,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  width: 5,
                ),
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

  Widget pointDetailsView() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: screenWidth * .3,
              height: screenWidth * .3,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.brightYellow,
                  width: .5,
                ),
              ),
            ),
            // Largest circle
            Container(
              width: screenWidth * .25,
              height: screenWidth * .25,
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
              ),
            ),
            // Medium circle inside the largest one
            Container(
              width: screenWidth * .2,
              height: screenWidth * .2,
              decoration: BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.brightYellow,
                  width: .5,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Points",
                      style:
                      TextStyle(color: AppColors.whiteColor, fontSize: 13),
                    ),
                    Text(
                      "2000",
                      style: TextStyle(
                          color: AppColors.whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
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
              width: collapsedCircleWidth,
              height: collapsedCircleWidth,
              decoration: const BoxDecoration(
                color: AppColors.blackColor,
                shape: BoxShape.circle,
              ),
            ),
            // Medium circle inside the largest one
            Container(
              width: collapsedCircleWidth * .8,
              height: collapsedCircleWidth * .8,
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

  Widget playerDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Gurup Wamsi Kumar(Guru)",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.surfaceDim),
        ),
        RichText(
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
        Container(
          margin: const EdgeInsets.only(left: 0, right: 0),
          width: screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              infoCard("Wicketkeeper", "25"),
              infoCard("Bowler", "12"),
              infoCard("All-rounder", "13"),
              infoCard("Finisher", "2"),
            ],
          ),
        )
      ],
    );
  }

  Widget currentBalanceSummary() {
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.apply(color: Theme.of(context).colorScheme.surfaceDim),
              children: const [
                TextSpan(text: 'My balance: '),
                TextSpan(
                  text: '1800',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge?.apply(color: Theme.of(context).colorScheme.surfaceDim),
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
    return Row(
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
          padding: const EdgeInsets.only(top: 8, right: 5),
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

  Widget auctionTopBar() {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      child: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Container(
          padding: const EdgeInsets.only(right: 20, left: 20),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(40),
                  bottomLeft: Radius.circular(40))),
          child: topSection(),
        ),
      ),
    );
  }
}
