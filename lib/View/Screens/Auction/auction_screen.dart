import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:gaimzone/View/Screens/Auction/close_confirm_sheet.dart';
import 'package:gaimzone/View/Screens/Auction/collapsed_view.dart';
import 'package:gaimzone/View/Screens/Auction/expanded_view.dart';
import 'package:gaimzone/View/Screens/Auction/settings_sheet.dart';
import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
import 'package:gaimzone/View/Widgets/custom_fab.dart';
import 'package:gaimzone/utils/images.dart';

import 'package:gaimzone/utils/colors.dart';

import '../../../utils/constants.dart';

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
  late Timer _timer;
  bool _isUserScrolling = false;
  bool _isScrollingForward = true;

  bool isShrunk = false;
  final ScrollController _viewScrollController = ScrollController();
  final ScrollController _sliderScrollController = ScrollController();
  bool _isPaused = false;

  final confettiController = ConfettiController();

  String auctionStatus = AppState.getAuctionStatus("live");

  bool isLoading = true;

  final CountDownController _countDownController = CountDownController();

  @override
  void initState() {
    super.initState();
    loadData();
    _startAutoScroll();
    _sliderScrollController.addListener(_checkScrollPosition);
    _viewScrollController.addListener(() {
      bool shrinkCondition = _viewScrollController.offset > 400;
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

  void _checkScrollPosition() {
    if (_sliderScrollController.hasClients) {
      double maxScroll = _sliderScrollController.position.maxScrollExtent;
      double minScroll = _sliderScrollController.position.minScrollExtent;
      double currentScroll = _sliderScrollController.offset;

      if (currentScroll >= maxScroll - 10) {
        _isScrollingForward = false;
      } else if (currentScroll <= minScroll + 10) {
        _isScrollingForward = true;
      }
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 40), (timer) {
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
    Future.delayed(const Duration(seconds: 2), () {
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
    _viewScrollController.dispose();
    _sliderScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.appBarHeight()),
          child: auctionTopBar(),
        ),
        body: NestedScrollView(
          controller: _viewScrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: auctionStatus == "closed"
                    ? Dimensions.backgroundHeight() - 150
                    : Dimensions.backgroundHeight(),
                collapsedHeight: 240,
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
                pinned: true,
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
                      color: AppState.isDarkMode(context)
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
        floatingActionButton: CustomFloatingActionButton(
            onPressedClose: showCloseConfirmation,
            onPressedSettings: showSettings),
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
              controller: _countDownController,
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

  Widget collapsedWidget() {
    return CollapsedView(
        auctionStatus: auctionStatus,
        isLoading: isLoading,
        countDownController: _countDownController);
  }

  Widget expandedWidget() {
    return ExpandedView(
      auctionStatus: auctionStatus,
      isLoading: isLoading,
      sliderScrollController: _sliderScrollController,
      countDownController: _countDownController,
      stopAutoScroll: _stopAutoScroll,
      resumeAutoScroll: _resumeAutoScroll,
      pauseAutoScroll: _pauseAutoScroll,
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

  Widget topSection() {
    return SizedBox(
      width: Dimensions.screenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isLoading
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
          isLoading
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
                  color: auctionStatus == "live"
                      ? Theme.of(context).colorScheme.surfaceBright
                      : Theme.of(context).colorScheme.error,
                  width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: isLoading
                ? CustomShimmer.shimmerDefault(context, height: 15, width: 30)
                : Text(
                    AppState.getAuctionStatus(auctionStatus),
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

  void showSettings() async {
    final result1 = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SettingsSheet(auctionStatus: auctionStatus);
          },
        );
      },
    );

    if (result1 != null) {
      setState(() {
        if (result1.isNotEmpty) {
          auctionStatus = result1;
          if (auctionStatus == "live") {}
        }
      });
    }
  }

  void showCloseConfirmation() async {
    final res = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return const CloseConfirmSheet();
          },
        );
      },
    );

    if (res != null) {
      setState(() {
        if (res.isNotEmpty) {
          auctionStatus = res;
          _countDownController.pause();
        }
      });
    }
  }
}
