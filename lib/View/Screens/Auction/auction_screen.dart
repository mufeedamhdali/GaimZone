import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
import 'package:gaimzone/utils/images.dart';

import 'package:gaimzone/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_tooltip/widget_tooltip.dart';

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverTabBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceTint,
            borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: tabBar,
      ),
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({
    super.key,
  });

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  final List<String> imageUrls = [
    AppImages.sliderImage,
    AppImages.sliderImage,
    AppImages.sliderImage,
  ];

  final PageController _pageController = PageController(initialPage: 0);
  ScrollController scrollControllerA = ScrollController();
  late Timer _timer;
  bool _isUserScrolling = false;
  bool _isAtEnd = false;
  bool _isScrollingForward = true;

  bool isShrunk = false; // Boolean to track shrink state
  ScrollController _viewScrollController = ScrollController();
  ScrollController _sliderScrollController = ScrollController();
  bool _isPaused = false;
  bool isPlayerSold = false;

  final confettiController = ConfettiController();
  double screenWidth = 0;
  String mobileNumber = "+91 9876543210";

  Map<String, String> getStringStatus = {
    "live": "Live",
    "stopped": "Stopped",
    "closed": "Stopped",
    "paused": "Paused"
  };

  double screenHeight = 0;

  // double titleHeight = 0;
  double backgroundHeight = 0;
  double appBarHeight = 0;
  double largeCircleWidth = 0;
  double curveWith = 0;

  // double gapWidth = 0;
  double tabViewHeight = 0;
  double collapsedCircleWidth = 0;

  String auctionStatus = 'live';

  // double topPadding = 0;
  // double imageViewHeight = 0;

  // double bidButtonViewHeight = 0;
  // double playersSummaryHeight = 0;
  // double balanceViewHeight = 0;
  double roundCornerHeight = 0;

  bool isBidEnabled = true;
  bool isDarkMode = true;
  bool isLoading = true;

  final CountDownController _controller = CountDownController();

  @override
  void initState() {
    super.initState();
    loadData();
    _startAutoScroll();
    _sliderScrollController.addListener(_checkScrollPosition);
    _viewScrollController.addListener(() {
      bool shrinkCondition =
          _viewScrollController.offset > 400; // Adjust threshold as needed
      if (shrinkCondition != isShrunk) {
        setState(() {
          isShrunk = shrinkCondition;
        });
      }
    });
  }

  loadData() async {
    await Future.delayed(const Duration(seconds: 3)).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }


  Widget _buildShimmerEndorsement(
      {double? height, double? width, Color? color, double? radius}) {
    return Shimmer.fromColors(
      baseColor: color?.withOpacity(.2) ??
          Theme.of(context).colorScheme.surfaceDim.withOpacity(.2),
      highlightColor: color?.withOpacity(.2) ??
          Theme.of(context).colorScheme.surfaceDim.withOpacity(.4),
      child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(radius ?? 5)),
          margin: const EdgeInsets.all(1),
          height: height,
          width: width),
    );
  }

  Widget _buildShimmerImage({double? height, double? width}) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceDim.withOpacity(.2),
      highlightColor: Theme.of(context).colorScheme.surfaceDim.withOpacity(.4),
      child: Container(
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          margin: const EdgeInsets.all(1),
          height: height,
          width: width),
    );
  }

  void _checkScrollPosition() {
    if (_sliderScrollController.hasClients) {
      double maxScroll = _sliderScrollController.position.maxScrollExtent;
      double minScroll = _sliderScrollController.position.minScrollExtent;
      double currentScroll = _sliderScrollController.offset;

      if (currentScroll >= maxScroll - 10) {
        _isScrollingForward = false; // Reverse direction
      } else if (currentScroll <= minScroll + 10) {
        _isScrollingForward = true; // Forward direction
      }
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(milliseconds: 40), (timer) {
      if (_sliderScrollController.hasClients &&
          !_isUserScrolling &&
          !_isPaused) {
        double newOffset =
            _sliderScrollController.offset + (_isScrollingForward ? 4 : -4);
        _sliderScrollController.animateTo(
          newOffset,
          duration: const Duration(milliseconds: 40),
          curve: Curves.linear,
        );
      }
    });
  }

  void _stopAutoScroll() {
    _isUserScrolling = true;
    Future.delayed(Duration(seconds: 2), () {
      _isUserScrolling = false;
    });
  }

  void _pauseAutoScroll() {
    setState(() {
      _isPaused = true;
    });
  }

  void _resumeAutoScroll() {
    setState(() {
      _isPaused = false;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    _viewScrollController.dispose();
    _sliderScrollController.dispose();
    super.dispose();
  }

  setDimension(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    print("screenHeight: " + screenHeight.toString());
    screenWidth = MediaQuery.of(context).size.width;
    print("screenWidth: " + screenWidth.toString());
    // titleHeight = screenHeight * .3;
    // print("titleHeight: " + titleHeight.toString());
    appBarHeight = 70;
    print("appBarHeight: " + appBarHeight.toString());
    largeCircleWidth = screenWidth * .22;
    print("largeCircleWidth: " + largeCircleWidth.toString());
    curveWith = largeCircleWidth * .7;
    print("curveWith: " + curveWith.toString());
    // gapWidth = largeCircleWidth * .07;
    // print("gapWidth: " + gapWidth.toString());
    // tabViewHeight = screenHeight * .6;
    // print("tabViewHeight: " + tabViewHeight.toString());
    collapsedCircleWidth = screenWidth * .18;
    print("collapsedCircleWidth: " + collapsedCircleWidth.toString());
    // topPadding = screenHeight * .1;
    // print("topPadding: " + topPadding.toString());
    // imageViewHeight = screenHeight * .585;
    // print("imageViewHeight: " + imageViewHeight.toString());
    // playersSummaryHeight = appBarHeight + screenHeight * .08;
    // print("playersSummaryHeight: " + playersSummaryHeight.toString());
    // bidButtonViewHeight = screenHeight * .15;
    // print("bidButtonViewHeight: " + bidButtonViewHeight.toString());
    // balanceViewHeight = screenHeight * .15;
    // print("balanceViewHeight: " + balanceViewHeight.toString());
    // roundCornerHeight = screenHeight * .07;
    // print("roundCornerHeight: " + roundCornerHeight.toString());
    backgroundHeight = 660;
    print("backgroundHeight: " + backgroundHeight.toString());

    isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    setDimension(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: auctionTopBar(),
        ),
        body: NestedScrollView(
          controller: _viewScrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: auctionStatus == "closed"
                    ? backgroundHeight - 150
                    : backgroundHeight,
                // Initial height of the blue container
                collapsedHeight: 240,
                // Shrunk height
                pinned: true,
                floating: false,
                snap: false,
                titleSpacing: 0,
                toolbarHeight: 240,
                elevation: 0,
                title: isShrunk ? collapsedWidget() : null,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: expandedWidget(),
                ),
              ),
              SliverPersistentHeader(
                pinned: true, // Keeps the TabBar fixed at the top
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: Theme.of(context).textTheme.titleMedium,
                    labelColor: AppColors.whiteColor,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.surfaceDim,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 0.0,
                      vertical: 0.0,
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: isDarkMode
                          ? Theme.of(context).colorScheme.tertiary
                          : Theme.of(context).primaryColor,
                    ),
                    tabs: const [
                      Tab(height: 60, text: "Activities"),
                      Tab(height: 60, text: "Squads"),
                      Tab(height: 60, text: "All Players"),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabView(isLoading: isLoading),
        ),
        floatingActionButton: SpeedDial(
          overlayOpacity: 0,
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
          direction: SpeedDialDirection.left,
          tooltip: 'Options',
          childrenButtonSize: const Size(56.0, 56.0),
          buttonSize: const Size(50.0, 50.0),
          shape: const CircleBorder(),
          icon: Icons.more_horiz,
          activeIcon: Icons.more_horiz,
          activeBackgroundColor: Theme.of(context).colorScheme.secondaryFixed,
          backgroundColor: Theme.of(context).primaryColor,
          children: [
            SpeedDialChild(
              backgroundColor: Theme.of(context).colorScheme.error,
              shape: const CircleBorder(),
              child: const Icon(Icons.close, color: AppColors.whiteColor),
              onTap: () => {showCloseConfirmation()},
            ),
            SpeedDialChild(
              backgroundColor: Theme.of(context).primaryColor,
              shape: const CircleBorder(),
              child: const Icon(
                Icons.settings,
                color: AppColors.whiteColor,
              ),
              onTap: () => {showSettings()},
            ),
          ],
        ),
      ),
    );
  }

  Widget collapsedWidget() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceTint,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 0),
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 2,
              ),
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
                height: collapsedCircleWidth * 1.1,
                width: collapsedCircleWidth * 1.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    playerImageViewSmall(),
                    (auctionStatus == "live" && !isPlayerSold)
                        ? Container()
                        : Opacity(
                            opacity: auctionStatus == "paused" ? .45 : .75,
                            child: Container(
                              width: collapsedCircleWidth,
                              height: collapsedCircleWidth,
                              decoration: BoxDecoration(
                                color: auctionStatus == "paused"
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
                    isLoading
                        ? _buildShimmerEndorsement(width: 20, height: 16)
                        : Text(
                            auctionStatus == "live" ? "2000" : "----",
                            style: const TextStyle(
                                color: AppColors.whiteColor,
                                fontSize: 13,
                                fontWeight: FontWeight.bold),
                          ),
                  )),
              SizedBox(
                width: 2,
              ),
            ],
          ),
          SizedBox(
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
                width: screenWidth * .7,
                child: isLoading
                    ? _buildShimmerEndorsement(width: 70, height: 30)
                    : Text(
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
            width: screenWidth * .74,
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

  Widget expandedWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: appBarHeight + screenHeight * .06,
          width: screenWidth,
          color: Theme.of(context).colorScheme.primary,
        ),
        Stack(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: auctionStatus == "closed" ? 500 : 400,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      auctionStatus == "closed"
                          ? Positioned(
                              top: 110,
                              child: pausedView(),
                            )
                          : Positioned(
                              top: 50,
                              child: isLoading
                                  ? _buildShimmerImage(
                                      height: screenWidth * .7,
                                      width: screenWidth * .7)
                                  : playerImageView()),
                      auctionStatus == "closed"
                          ? Container()
                          : Positioned(bottom: 0, child: pointDetailsView()),
                      auctionStatus == "closed"
                          ? Container()
                          : isLoading
                              ? Container()
                              : Positioned(
                                  top: screenWidth * .5,
                                  right: screenWidth * .16,
                                  child: SvgPicture.asset(
                                    AppImages.bookmarkBadge,
                                    width: screenWidth * .12,
                                  ),
                                ),
                    ],
                  ),
                ),
                Visibility(
                  visible: auctionStatus == "paused",
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: Colors.transparent,
                    child: Text(
                      "PAUSED",
                      style: const TextStyle(
                          fontSize: 50,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Visibility(
                  visible: isPlayerSold && auctionStatus == "live",
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        color: Colors.transparent,
                        child: Text(
                          "SOLD",
                          style: const TextStyle(
                              fontSize: 50,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: isDarkMode
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
                              SizedBox(
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
                  visible: auctionStatus == "stopped",
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    width: screenWidth * .6,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                        borderRadius: BorderRadius.circular(50)),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
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
                // (auctionStatus == "paused" ||
                //         auctionStatus == "stoppped" ||
                //         isPlayerSold)
                //     ? ((auctionStatus == "paused" || isPlayerSold)
                //         ? Column(
                //             children: [
                //
                //               isPlayerSold
                //                   ?
                //                   : Container()
                //             ],
                //           )
                //         : isPlayerSold
                //             ? Container()
                //             : )
                //     : Container(),
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
                  width: screenWidth,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 0, bottom: 10),
                  child: playersSummary(),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    width: curveWith + largeCircleWidth + curveWith,
                    height: largeCircleWidth / 2,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Positioned(
                          left: curveWith,
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(largeCircleWidth / 2),
                                topRight: Radius.circular(largeCircleWidth / 2),
                              ),
                            ),
                            width: largeCircleWidth,
                            height: largeCircleWidth / 2,
                          ),
                        ),
                        Positioned(
                          bottom: -12,
                          right: curveWith + largeCircleWidth - 15,
                          child: Transform(
                            transform: Matrix4.identity()..scale(-1.0, 1.0),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppImages.rightCurve,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.surface,
                                BlendMode.srcIn,
                              ),
                              width: curveWith,
                              height: largeCircleWidth * .5,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: -12,
                            left: curveWith + largeCircleWidth - 15,
                            child: SvgPicture.asset(
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.surface,
                                BlendMode.srcIn,
                              ),
                              height: largeCircleWidth * .5,
                              AppImages.rightCurve,
                              width: curveWith,
                              fit: BoxFit.fitWidth,
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            (auctionStatus == "live" || auctionStatus == "paused")
                ? Positioned(
                    top: 20,
                    left: (screenWidth / 2) - (largeCircleWidth * .9 / 2),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            shape: BoxShape.circle,
                          ),
                          width: largeCircleWidth * .9,
                          height: largeCircleWidth * .9,
                        ),
                        timeTicker(Theme.of(context).colorScheme.surface),
                      ],
                    ))
                : Positioned(
                    top: 30,
                    left: screenWidth / 4,
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          padding: EdgeInsets.all(5),
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
                          width: screenWidth * .5,
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
                                  int hours =
                                      (time / 3600).floor(); // Extract hours
                                  int minutes = ((time % 3600) / 60)
                                      .floor(); // Extract minutes
                                  int seconds =
                                      (time % 60).floor(); // Extract seconds

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
        auctionStatus == "closed"
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
                      width: screenWidth,
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
                              width: screenWidth * .8,
                              child: isLoading
                                  ? _buildShimmerEndorsement(
                                      width: 70, height: 20)
                                  : Text(
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
                          isLoading
                              ? _buildShimmerEndorsement(
                                  height: 20, width: screenWidth * .5)
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
                        // color: Colors.yellow,
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

  Widget pausedView() {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
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
                            color: isDarkMode
                                ? DarkColors.gray002
                                : LightColors.gray002)),
                    SizedBox(
                      height: 20,
                      child: Switch(
                        inactiveThumbColor: AppColors.darkGrey.withOpacity(.5),
                        trackOutlineColor:
                            WidgetStateProperty.resolveWith<Color?>(
                          (states) {
                            if (states.contains(MaterialState.selected)) {
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
            ),
            width: screenWidth * .9,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                    color: Theme.of(context).colorScheme.surfaceTint),
                borderRadius: BorderRadius.circular(20))),
        SizedBox(
          height: 10,
        ),

        // SingleChildScrollView(
        //   child: Container(
        //     height: 240,
        //     width: MediaQuery.of(context).size.width,
        //     child: AutoScrollSlider(
        //       duration: 20,
        //       scrollDirection: Axis.horizontal,
        //       length: imageUrls.length,
        //       scrollController: scrollControllerA,
        //       itemBuilder: (context, index) {
        //         return Row(
        //           children: [
        //             index != 0
        //                 ? Container(
        //                     margin: const EdgeInsets.all(5),
        //                     height: 240,
        //                     width: MediaQuery.of(context).size.width * .4,
        //                     decoration: BoxDecoration(
        //                         color:
        //                             Theme.of(context).colorScheme.surfaceTint,
        //                         borderRadius: BorderRadius.circular(150)),
        //                     child: Column(
        //                       children: [
        //                         Stack(
        //                           alignment: Alignment.center,
        //                           children: [
        //                             Container(
        //                               padding: const EdgeInsets.only(
        //                                   top: 15,
        //                                   left: 15,
        //                                   right: 15,
        //                                   bottom: 20),
        //                               margin: const EdgeInsets.only(bottom: 0),
        //                               decoration: BoxDecoration(
        //                                   color: Theme.of(context)
        //                                       .colorScheme
        //                                       .surfaceTint,
        //                                   shape: BoxShape.circle),
        //                               child: Image.asset(AppImages.playerImage),
        //                             ),
        //                             Positioned(
        //                               bottom: 0,
        //                               child: SvgPicture.asset(
        //                                 AppImages.bookmarkBadge,
        //                                 width: 40,
        //                                 height: 40,
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                         const SizedBox(
        //                           height: 5,
        //                         ),
        //                         Text(
        //                           "Srinath Singh",
        //                           style:
        //                               Theme.of(context).textTheme.titleMedium,
        //                         ),
        //                         Text(
        //                           "32 yrs, Striker",
        //                           style: Theme.of(context).textTheme.bodyMedium,
        //                         ),
        //                       ],
        //                     ),
        //                   )
        //                 : Container(
        //                     margin: const EdgeInsets.all(5),
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(24),
        //                       color: Theme.of(context).colorScheme.surfaceTint,
        //                     ),
        //                     alignment: Alignment.topCenter,
        //                     child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.end,
        //                       children: [
        //                         Expanded(
        //                           child: ClipRRect(
        //                             borderRadius: BorderRadius.circular(20),
        //                             // Adjust the radius for curve effect
        //                             child: Image.asset(
        //                               imageUrls[index],
        //                               width: 300,
        //                               fit: BoxFit.fitHeight,
        //                             ),
        //                           ),
        //                         ),
        //                         // Image.network(
        //                         //   imageUrls[index],
        //                         //   height: 160,
        //                         //   width: MediaQuery.of(context).size.width,
        //                         //   fit: BoxFit.cover,
        //                         // ),
        //                         SizedBox(
        //                           height: 3,
        //                         ),
        //                         Text(
        //                           "Title",
        //                           style: Theme.of(context).textTheme.bodyMedium,
        //                         ),
        //                         SizedBox(
        //                           height: 3,
        //                         ),
        //                         Text(
        //                           "Sub Title",
        //                           style: Theme.of(context).textTheme.bodySmall,
        //                         ),
        //                         SizedBox(
        //                           height: 3,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //           ],
        //         );
        //       },
        //     ),
        //   ),
        // ),

        SizedBox(
          height: 240,
          width: screenWidth,
          child: GestureDetector(
            onPanDown: (_) => _stopAutoScroll(),
            onLongPress: _pauseAutoScroll,
            onLongPressUp: _resumeAutoScroll,
            child: ListView.builder(
              controller: _sliderScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: imageUrls.length * 2,
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
                                // Adjust the radius for curve effect
                                child: Image.asset(
                                  imageUrls[0],
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                            // Image.network(
                            //   imageUrls[index],
                            //   height: 160,
                            //   width: MediaQuery.of(context).size.width,
                            //   fit: BoxFit.cover,
                            // ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Title",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "Sub Title",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            SizedBox(
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

        // Container(
        //   height: 240,
        //   width: screenWidth,
        //   child: FlutterCarousel(
        //     options: FlutterCarouselOptions(
        //       padEnds: true,
        //       allowImplicitScrolling: true,
        //       pageSnapping: false,
        //       floatingIndicator: false,
        //       autoPlay: true,
        //       autoPlayInterval: const Duration(seconds: 2),
        //       height: 400.0,
        //       showIndicator: true,
        //       slideIndicator: CircularSlideIndicator(
        //           slideIndicatorOptions: SlideIndicatorOptions(
        //               currentIndicatorColor:
        //                   Theme.of(context).colorScheme.primary,
        //               indicatorBackgroundColor:
        //                   Theme.of(context).colorScheme.outline,
        //               indicatorRadius: 5,
        //               itemSpacing: 15)),
        //     ),
        //     items: wList(),
        //   ),
        // ),
        // SizedBox(
        //   height: 3,
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: List.generate(2, (index) {
        //     return Container(
        //       margin: EdgeInsets.symmetric(horizontal: 5),
        //       width: 8,
        //       height: 8,
        //       decoration: BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: _currentPage == index
        //             ? Theme.of(context).colorScheme.primary
        //             : Theme.of(context).colorScheme.outline,
        //       ),
        //     );
        //   }),
        // ),
        SizedBox(
          height: 10,
        ),
        Container(
            padding: EdgeInsets.all(10),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
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
            width: screenWidth * .9,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(10)))
      ],
    );
  }

  List<Widget> wList() {
    Widget item1 = Container(
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
                    color: Theme.of(context).colorScheme.surfaceTint,
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
    Widget item2 = Container(
      margin: const EdgeInsets.all(5),
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
              // Adjust the radius for curve effect
              child: Image.asset(
                imageUrls[0],
                width: 300,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          // Image.network(
          //   imageUrls[index],
          //   height: 160,
          //   width: MediaQuery.of(context).size.width,
          //   fit: BoxFit.cover,
          // ),
          SizedBox(
            height: 3,
          ),
          Text(
            "Title",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "Sub Title",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          SizedBox(
            height: 3,
          ),
        ],
      ),
    );

    List<Widget> temp = [item2, item1, item1, item1];
    return temp;
  }

  Widget topSection() {
    return SizedBox(
      width: screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLoading
              ? _buildShimmerImage(
                  height: screenWidth * .1, width: screenWidth * .1)
              : Stack(
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
          isLoading
              ? _buildShimmerEndorsement(height: 18, width: screenWidth * .6)
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
                  color: auctionStatus == "live"
                      ? Theme.of(context).colorScheme.surfaceBright
                      : Theme.of(context).colorScheme.error,
                  width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: isLoading
                ? _buildShimmerEndorsement(height: 15, width: 30)
                : Text(
                    getStringStatus[auctionStatus] ?? "",
                    style: TextStyle(
                        color: auctionStatus == "live"
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
          width: largeCircleWidth * .8,
          height: largeCircleWidth * .8,
        ),
        Stack(
          children: [
            CircularCountDownTimer(
              duration: 60,
              initialDuration: 0,
              controller: _controller,
              width: largeCircleWidth * .6,
              height: largeCircleWidth * .6,
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
              top: largeCircleWidth * .35,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: largeCircleWidth * .6,
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
                  color: AppColors.primary10,
                  width: 1,
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
            Stack(
              children: [
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
                (auctionStatus == "live" && !isPlayerSold)
                    ? Container()
                    : Opacity(
                        opacity: auctionStatus == "paused" ? .45 : .75,
                        child: Container(
                          width: screenWidth * .6,
                          height: screenWidth * .6,
                          decoration: BoxDecoration(
                            color: auctionStatus == "paused"
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

  Widget playerImageViewSmall() {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(3),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Medium circle inside the largest one
            Opacity(
              opacity: 0.13,
              child: Container(
                width: collapsedCircleWidth * 1.1,
                height: collapsedCircleWidth * 1.1,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceTint,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Opacity(
              opacity: 0.13,
              child: Container(
                width: collapsedCircleWidth,
                height: collapsedCircleWidth,
                decoration: const BoxDecoration(
                  color: AppColors.blackColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Smallest circle inside the medium one
            Opacity(
              opacity: .36,
              child: Container(
                width: collapsedCircleWidth * .9,
                height: collapsedCircleWidth * .9,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Container(
              width: collapsedCircleWidth * .8,
              height: collapsedCircleWidth * .8,
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
              width: screenWidth * .21,
              height: screenWidth * .21,
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
                    isLoading
                        ? _buildShimmerEndorsement(height: 16)
                        : Text(
                            auctionStatus == "live" ? "2000" : "----",
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isLoading
            ? _buildShimmerEndorsement(height: 18, width: screenWidth * .7)
            : Text(
                "Gurup Wamsi Kumar(Guru)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.surfaceDim),
              ),
        isLoading
            ? _buildShimmerEndorsement(height: 18, width: screenWidth * .5)
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
        isLoading
            ? _buildShimmerEndorsement(height: 20)
            : Container(
                margin: const EdgeInsets.only(left: 5, right: 5),
                width: screenWidth,
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
      width: screenWidth,
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isLoading
              ? _buildShimmerEndorsement(height: 18, width: screenWidth * .3)
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
          isLoading
              ? _buildShimmerEndorsement(height: 18, width: screenWidth * .3)
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
    return isLoading
        ? _buildShimmerEndorsement(height: 15, width: screenWidth * .2)
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

  Widget auctionTopBar() {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
      child: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        shadowColor: Colors.transparent,
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

  void showContactDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
            width: screenWidth,
            padding: const EdgeInsets.all(16),
            child: Container(
              width: screenWidth,
              height: 400,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Franchise",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return contactCard();
                      },
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  Widget contactCard() {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
        left: 2,
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 1, color: Theme.of(context).colorScheme.outline)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Lufga',
                    color: Theme.of(context).colorScheme.surfaceDim,
                  ),
                  children: [
                    const TextSpan(
                      text: "Suresh",
                    ),
                    TextSpan(
                        text: "\n+91 9182726356",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.surfaceDim)),
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => copyToClipboard(context),
                child: CircleAvatar(
                  radius: 22, // Size of the circle
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .surface, // Circle background color
                  child: Icon(
                    Icons.copy, // Icon you want inside the circle
                    color:
                        Theme.of(context).colorScheme.surfaceDim, // Icon color
                    size: 24, // Icon size
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () => openDialer,
                child: CircleAvatar(
                  radius: 22, // Size of the circle
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary, // Circle background color
                  child: const Icon(
                    Icons.call, // Icon you want inside the circle
                    color: Colors.white, // Icon color
                    size: 24, // Icon size
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: mobileNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to clipboard: $mobileNumber")),
    );
  }

  void openDialer() async {
    final Uri dialerUri = Uri(scheme: "tel", path: mobileNumber);
    if (await canLaunchUrl(dialerUri)) {
      await launchUrl(dialerUri);
    } else {
      print("Could not open dialer");
    }
  }

  DateTime? _selectedDate;
  DateTime? _selectedDate2;
  TimeOfDay? _selectedTime;

  showSettings() async {
    bool isAutoSwitched = true;
    bool isStopSwitched = true;
    bool isStopSwitchActive = true;
    bool auctionLive = auctionStatus == "live" ? true : false;
    String? selectedValue;

    final List<String> items = [
      'All Franchaises are not online',
      'Reason 2',
      'Reason 3'
    ];
    String result = "";

    final result1 = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0), // Rounded top corners
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return StatefulBuilder(
          // Needed to manage state inside the bottom sheet
          builder: (context, setModalState) {
            Widget auctionTabView() {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: 1)),
                      width: screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Auto Pause",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              WidgetTooltip(
                                triangleColor: Colors.black12,
                                messageDecoration: const BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                triggerMode: WidgetTooltipTriggerMode.tap,
                                dismissMode:
                                    WidgetTooltipDismissMode.tapAnyWhere,
                                message: Text('Info message',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceDim)),
                                child: Opacity(
                                  opacity: .2,
                                  child: Icon(
                                    Icons.info,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceDim,
                                    size: 15,
                                  ),
                                ),
                              ),
                              // Opacity(
                              //     opacity: .2,
                              //     child: Tooltip(
                              //       message: "vggcv ",
                              //       decoration: BoxDecoration(
                              //         color: Colors.black87,
                              //         borderRadius: BorderRadius.circular(8),
                              //       ),
                              //       child: Icon(
                              //         Icons.info,
                              //         color: Theme.of(context)
                              //             .colorScheme
                              //             .surfaceDim,
                              //         size: 15,
                              //       ),
                              //     ))
                            ],
                          ),
                          Switch(
                            inactiveThumbColor:
                                AppColors.darkGrey.withOpacity(.5),
                            trackOutlineColor:
                                WidgetStateProperty.resolveWith<Color?>(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return null;
                                }
                                return AppColors.darkGrey.withOpacity(.5);
                              },
                            ),
                            value: isAutoSwitched,
                            onChanged: (value) {
                              setModalState(() {
                                isAutoSwitched = value;
                              });
                              setState(() {
                                isAutoSwitched = value;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: 1)),
                      width: screenWidth,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Stop Auction",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Switch(
                                inactiveThumbColor:
                                    AppColors.darkGrey.withOpacity(.5),
                                trackOutlineColor:
                                    WidgetStateProperty.resolveWith<Color?>(
                                  (states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return null;
                                    }
                                    return AppColors.darkGrey.withOpacity(.5);
                                  },
                                ),
                                activeTrackColor:
                                    Theme.of(context).colorScheme.primary,
                                // activeTrack: Theme.of(context).colorScheme.surface,
                                value: isStopSwitched,
                                onChanged: (value) {
                                  isStopSwitchActive
                                      ? {
                                          setModalState(() {
                                            isStopSwitched = value;
                                          }),
                                          setState(() {
                                            isStopSwitched = value;
                                          })
                                        }
                                      : null;
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          auctionLive
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Reason",
                                    ),
                                    Container(
                                      width: screenWidth * .5,
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: DropdownButtonFormField<String>(
                                        padding: EdgeInsets.zero,
                                        value: selectedValue,
                                        decoration: InputDecoration(
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 12),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                width: .6,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .outline,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        hint: const Text('Select'),
                                        isExpanded: true,
                                        isDense: true,
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: null,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              height: 16,
                                              child: const Text(
                                                'Select',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                          ...items.map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    height: 16,
                                                    child: Text(item)),
                                              )),
                                        ],
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedValue = newValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 20, right: 20),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: BorderRadius.circular(30)),
                                  alignment: Alignment.center,
                                  width: screenWidth * .6,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "10 June",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.normal,
                                            color: AppColors.whiteColor),
                                      ),
                                      Countdown(
                                        seconds: 1000,
                                        build: (_, double time) {
                                          int hours = (time / 3600)
                                              .floor(); // Extract hours
                                          int minutes = ((time % 3600) / 60)
                                              .floor(); // Extract minutes
                                          int seconds = (time % 60)
                                              .floor(); // Extract seconds

                                          return Text(
                                            "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.whiteColor),
                                          );
                                        },
                                        onFinished: () => {},
                                      )
                                    ],
                                  ),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          auctionLive
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Set Time",
                                    ),
                                    Container(
                                      width: screenWidth * .5,
                                      height: 30,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: GestureDetector(
                                        onTap: () async {
                                          DateTime? picked =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                _selectedDate ?? DateTime.now(),
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2101),
                                            initialEntryMode:
                                                DatePickerEntryMode
                                                    .calendarOnly,
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  datePickerTheme:
                                                      DatePickerThemeData(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    headerHelpStyle:
                                                        const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                                child: child!,
                                              );
                                            },
                                          );

                                          if (picked != null) {
                                            setModalState(() {
                                              _selectedDate = picked;
                                            });
                                            if (_selectedDate != null) {
                                              DateTime initialTime =
                                                  DateTime.now();
                                              showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  DateTime pickedTime =
                                                      initialTime;
                                                  return SizedBox(
                                                    height: 250,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Select Time",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium,
                                                              ),
                                                              TextButton(
                                                                style: TextButton
                                                                    .styleFrom(
                                                                  foregroundColor:
                                                                      Colors
                                                                          .white,
                                                                  backgroundColor: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary,
                                                                  // Button background color
                                                                  textStyle: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall,
                                                                  // Text style
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          0,
                                                                      horizontal:
                                                                          0),
                                                                  // Padding
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20)), // Button shape
                                                                ),
                                                                child:
                                                                    const Text(
                                                                        "Done"),
                                                                onPressed:
                                                                    () async {
                                                                  setModalState(
                                                                      () {
                                                                    _selectedTime =
                                                                        TimeOfDay.fromDateTime(
                                                                            pickedTime);
                                                                  });
                                                                  if (_selectedTime !=
                                                                      null) {
                                                                    setModalState(
                                                                        () {
                                                                      _selectedDate2 =
                                                                          DateTime(
                                                                        _selectedDate!
                                                                            .year,
                                                                        _selectedDate!
                                                                            .month,
                                                                        _selectedDate!
                                                                            .day,
                                                                        _selectedTime!
                                                                            .hour,
                                                                        _selectedTime!
                                                                            .minute,
                                                                      );
                                                                    });
                                                                    // await getFormattedDateTime(_selectedDate2, _selectedTime);
                                                                    //
                                                                  }
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child:
                                                              CupertinoDatePicker(
                                                            mode:
                                                                CupertinoDatePickerMode
                                                                    .time,
                                                            initialDateTime:
                                                                initialTime,
                                                            use24hFormat: false,
                                                            onDateTimeChanged:
                                                                (DateTime
                                                                    time) {
                                                              setModalState(() {
                                                                pickedTime =
                                                                    time;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              _selectedDate2 == null
                                                  ? '---'
                                                  : DateFormat('MMMM d, y')
                                                      .format(_selectedDate2!),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                            Container(
                                              height: 30,
                                              width: screenWidth * .2,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    width: .5),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                _selectedDate2 == null
                                                    ? '---'
                                                    : DateFormat('hh:mm a')
                                                        .format(
                                                            _selectedDate2!),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Text("Reason: ${selectedValue ?? ""}"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    auctionLive
                        ? InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Wrap(
                                    children: [
                                      Container(
                                        width: screenWidth,
                                        padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.close,
                                                    size: 30,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surfaceDim)),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  AppImages.alertSign,
                                                  width: 50,
                                                  height: 50,
                                                  colorFilter: ColorFilter.mode(
                                                    isDarkMode
                                                        ? DarkColors
                                                            .notificationOrange
                                                        : LightColors
                                                            .notificationOrange,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  "Do you want to STOP this auction?",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 24,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                bottom: 10),
                                                        margin: const EdgeInsets
                                                            .only(
                                                            top: 10,
                                                            bottom: 10,
                                                            left: 10,
                                                            right: 10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .surface,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        alignment:
                                                            Alignment.center,
                                                        width:
                                                            screenWidth * .35,
                                                        child: Text(
                                                          "Cancel",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge,
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        setModalState(() {
                                                          auctionLive = false;
                                                          result = "stopped";
                                                          isStopSwitchActive =
                                                              false;
                                                        });
                                                        Navigator.pop(
                                                            context, result);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 10,
                                                                bottom: 10),
                                                        margin: const EdgeInsets
                                                            .only(
                                                            top: 10,
                                                            bottom: 10,
                                                            left: 10,
                                                            right: 10),
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        alignment:
                                                            Alignment.center,
                                                        width:
                                                            screenWidth * .35,
                                                        child: const Text(
                                                            "Yes, stop",
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .whiteColor)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Visibility(
                              visible: isStopSwitched,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(30)),
                                alignment: Alignment.center,
                                width: screenWidth * .7,
                                child: const Text(
                                  "Stop Auction",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setModalState(() {
                                    auctionLive = false;
                                    result = "closed";
                                    isStopSwitchActive = true;
                                  });
                                  Navigator.pop(context, result);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(30)),
                                  alignment: Alignment.center,
                                  width: screenWidth * .35,
                                  child: Text(
                                    "Update",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return Wrap(
                                        children: [
                                          Container(
                                            width: screenWidth,
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(Icons.close,
                                                        size: 30,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .surfaceDim)),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      AppImages.alertSign,
                                                      width: 50,
                                                      height: 50,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                        isDarkMode
                                                            ? DarkColors
                                                                .notificationOrange
                                                            : LightColors
                                                                .notificationOrange,
                                                        BlendMode.srcIn,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                        width: screenWidth * .7,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration: BoxDecoration(
                                                            color: isDarkMode
                                                                ? DarkColors
                                                                    .highlightYellow
                                                                : LightColors
                                                                    .highlightYellow,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            SvgPicture.asset(
                                                              AppImages
                                                                  .alertSign2,
                                                              width: 24,
                                                              height: 24,
                                                              colorFilter:
                                                                  ColorFilter
                                                                      .mode(
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .surfaceDim,
                                                                BlendMode.srcIn,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "2 franchises are offline",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                            ),
                                                          ],
                                                        )),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Do you want to RESUME this auction?",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    bottom: 10),
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    left: 10,
                                                                    right: 10),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .surface,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            alignment: Alignment
                                                                .center,
                                                            width: screenWidth *
                                                                .35,
                                                            child: Text(
                                                              "Cancel",
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleLarge,
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setModalState(() {
                                                              auctionLive =
                                                                  true;
                                                              result = "live";
                                                              isStopSwitchActive =
                                                                  true;
                                                            });
                                                            Navigator.pop(
                                                                context,
                                                                result);
                                                          },
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    bottom: 10),
                                                            margin:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 10,
                                                                    bottom: 10,
                                                                    left: 10,
                                                                    right: 10),
                                                            decoration: BoxDecoration(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30)),
                                                            alignment: Alignment
                                                                .center,
                                                            width: screenWidth *
                                                                .35,
                                                            child: const Text(
                                                                "Yes, Resume",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .whiteColor)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(30)),
                                  alignment: Alignment.center,
                                  width: screenWidth * .35,
                                  child: const Text("Resume",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor)),
                                ),
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              );
            }

            Widget callInfoCard(BuildContext context) {
              return GestureDetector(
                onTap: () {
                  showContactDetails(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 8,
                    left: 2,
                  ),
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.outline)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.frIcon,
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Phoenix",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.surfaceBright,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Online",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.normal,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 22, // Size of the circle
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary, // Circle background color
                            child: const Icon(
                              Icons.call, // Icon you want inside the circle
                              color: Colors.white, // Icon color
                              size: 24, // Icon size
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }

            Widget franchisesTabView() {
              return Container(
                width: screenWidth,
                height: 400,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return callInfoCard(context);
                  },
                ),
              );
            }

            return Wrap(
              children: [
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pause/Start Auction",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context, result);
                              },
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Theme.of(context).colorScheme.surfaceDim,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 20, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryFixed,
                                    width: 1)),
                            width: screenWidth * .425,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Lufga',
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surfaceBright,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: "Online",
                                          ),
                                          TextSpan(
                                              text: "\nFranchise",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceDim)),
                                        ])),
                                Text(
                                  "10",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceDim,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 10, right: 20, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondaryFixed,
                                    width: 1)),
                            width: screenWidth * .425,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Lufga',
                                          color: isDarkMode
                                              ? DarkColors.notificationOrange
                                              : LightColors.notificationOrange,
                                        ),
                                        children: [
                                          const TextSpan(
                                            text: "Offline",
                                          ),
                                          TextSpan(
                                              text: "\nFranchise",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 16,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surfaceDim)),
                                        ])),
                                Text(
                                  "4",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceDim,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.surfaceTint,
                                  borderRadius: BorderRadius.circular(30)),
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              child: TabBar(
                                indicatorSize: TabBarIndicatorSize.tab,
                                labelStyle:
                                    Theme.of(context).textTheme.titleMedium,
                                labelColor: AppColors.whiteColor,
                                unselectedLabelColor:
                                    Theme.of(context).colorScheme.surfaceDim,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0.0,
                                  vertical: 0.0,
                                ),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: isDarkMode
                                      ? Theme.of(context).colorScheme.tertiary
                                      : Theme.of(context).primaryColor,
                                ),
                                tabs: const [
                                  Tab(height: 40, text: "Auction"),
                                  Tab(height: 40, text: "Franchises"),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenHeight * .5,
                              child: TabBarView(
                                children: [
                                  auctionTabView(),
                                  franchisesTabView(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (result1 != null) {
      setState(() {
        if (result1.isNotEmpty) {
          auctionStatus = result1;
          if (auctionStatus == "live") {
            // _controller.start();
          }
        }
      });
    }
  }

  showCloseConfirmation() async {
    String result = "";
    bool isSwitched = true;
    final res = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0), // Rounded top corners
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return StatefulBuilder(
          // Needed to manage state inside the bottom sheet
          builder: (context, setModalState) {
            return Wrap(
              children: [
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context, result);
                          },
                          child: Icon(Icons.close,
                              size: 30,
                              color: Theme.of(context).colorScheme.surfaceDim)),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppImages.alertSign,
                            width: 50,
                            height: 50,
                            colorFilter: ColorFilter.mode(
                              isDarkMode
                                  ? DarkColors.notificationOrange
                                  : LightColors.notificationOrange,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Do you want to CLOSE betting on this Auction?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, result);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: BorderRadius.circular(30)),
                                  alignment: Alignment.center,
                                  width: screenWidth * .35,
                                  child: Text(
                                    "Cancel",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setModalState(() {
                                    result = "paused";
                                  });
                                  Navigator.pop(context, result);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 10, right: 10),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(30)),
                                  alignment: Alignment.center,
                                  width: screenWidth * .35,
                                  child: const Text("Yes, Close",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.whiteColor)),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    if (res != null) {
      setState(() {
        if (res.isNotEmpty) {
          auctionStatus = res;
          _controller.pause();
        }
      });
    }
  }
}
