// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_confetti/flutter_confetti.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
// import 'package:gaimzone/utils/images.dart';
//
// import 'package:gaimzone/utils/colors.dart';
// import 'package:intl/intl.dart';
// import 'package:timer_count_down/timer_count_down.dart';
//
// /// Custom SliverPersistentHeader Delegate for TabBar
// class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;
//
//   _SliverTabBarDelegate(this.tabBar);
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Theme.of(context).colorScheme.surface,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surfaceTint,
//             borderRadius: BorderRadius.circular(30)),
//         padding: const EdgeInsets.all(5),
//         margin: const EdgeInsets.all(5),
//         child: tabBar,
//       ),
//     );
//   }
//
//   @override
//   double get maxExtent => tabBar.preferredSize.height;
//
//   @override
//   double get minExtent => tabBar.preferredSize.height;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
//
// class AuctionScreen extends StatefulWidget {
//   const AuctionScreen({
//     super.key,
//   });
//
//   @override
//   State<AuctionScreen> createState() => _AuctionScreenState();
// }
//
// class _AuctionScreenState extends State<AuctionScreen> {
//   bool isShrunk = false; // Boolean to track shrink state
//   ScrollController _scrollController = ScrollController();
//
//   final confettiController = ConfettiController();
//   double screenWidth = 0;
//
//   double screenHeight = 0;
//   // double titleHeight = 0;
//   double backgroundHeight = 0;
//   double appBarHeight = 0;
//   double largeCircleWidth = 0;
//   double curveWith = 0;
//   // double gapWidth = 0;
//   double tabViewHeight = 0;
//   double collapsedCircleWidth = 0;
//
//   // double topPadding = 0;
//   // double imageViewHeight = 0;
//
//   // double bidButtonViewHeight = 0;
//   // double playersSummaryHeight = 0;
//   // double balanceViewHeight = 0;
//   double roundCornerHeight = 0;
//
//   bool isBidEnabled = true;
//   bool isDarkMode = true;
//
//   final CountDownController _controller = CountDownController();
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       bool shrinkCondition =
//           _scrollController.offset > 400; // Adjust threshold as needed
//       if (shrinkCondition != isShrunk) {
//         setState(() {
//           isShrunk = shrinkCondition;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   setDimension(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     print("screenHeight: " + screenHeight.toString());
//     screenWidth = MediaQuery.of(context).size.width;
//     print("screenWidth: " + screenWidth.toString());
//     // titleHeight = screenHeight * .3;
//     // print("titleHeight: " + titleHeight.toString());
//     appBarHeight = 70;
//     print("appBarHeight: " + appBarHeight.toString());
//     largeCircleWidth = screenWidth * .22;
//     print("largeCircleWidth: " + largeCircleWidth.toString());
//     curveWith = largeCircleWidth * .7;
//     print("curveWith: " + curveWith.toString());
//     // gapWidth = largeCircleWidth * .07;
//     // print("gapWidth: " + gapWidth.toString());
//     // tabViewHeight = screenHeight * .6;
//     // print("tabViewHeight: " + tabViewHeight.toString());
//     collapsedCircleWidth = screenWidth * .17;
//     print("collapsedCircleWidth: " + collapsedCircleWidth.toString());
//     // topPadding = screenHeight * .1;
//     // print("topPadding: " + topPadding.toString());
//     // imageViewHeight = screenHeight * .585;
//     // print("imageViewHeight: " + imageViewHeight.toString());
//     // playersSummaryHeight = appBarHeight + screenHeight * .08;
//     // print("playersSummaryHeight: " + playersSummaryHeight.toString());
//     // bidButtonViewHeight = screenHeight * .15;
//     // print("bidButtonViewHeight: " + bidButtonViewHeight.toString());
//     // balanceViewHeight = screenHeight * .15;
//     // print("balanceViewHeight: " + balanceViewHeight.toString());
//     // roundCornerHeight = screenHeight * .07;
//     // print("roundCornerHeight: " + roundCornerHeight.toString());
//     backgroundHeight = 660;
//     print("backgroundHeight: " + backgroundHeight.toString());
//
//     isDarkMode = Theme.of(context).brightness == Brightness.dark;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     setDimension(context);
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         extendBodyBehindAppBar: true,
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(appBarHeight),
//           child: auctionTopBar(),
//         ),
//         body: NestedScrollView(
//           controller: _scrollController,
//           headerSliverBuilder: (context, innerBoxIsScrolled) {
//             return [
//               SliverAppBar(
//                 expandedHeight: backgroundHeight,
//                 // Initial height of the blue container
//                 collapsedHeight: 200,
//                 // Shrunk height
//                 pinned: true,
//                 titleSpacing: 0,
//                 toolbarHeight: 200,
//                 title: isShrunk ? collapsedWidget() : null,
//                 flexibleSpace: FlexibleSpaceBar(
//
//                   collapseMode: CollapseMode.pin,
//                   background: expandedWidget(),
//                 ),
//               ),
//               SliverPersistentHeader(
//                 pinned: true, // Keeps the TabBar fixed at the top
//                 delegate: _SliverTabBarDelegate(
//                   TabBar(
//                     indicatorSize: TabBarIndicatorSize.tab,
//                     labelStyle: Theme.of(context).textTheme.titleMedium,
//                     labelColor: AppColors.whiteColor,
//                     unselectedLabelColor:
//                     Theme.of(context).colorScheme.surfaceDim,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 0.0,
//                       vertical: 0.0,
//                     ),
//                     indicator: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30.0),
//                       color: isDarkMode
//                           ? Theme.of(context).colorScheme.tertiary
//                           : Theme.of(context).primaryColor,
//                     ),
//                     tabs: const [
//                       Tab(height: 60, text: "Activities"),
//                       Tab(height: 60, text: "Squads"),
//                       Tab(height: 60, text: "All Players"),
//                     ],
//                   ),
//                 ),
//               ),
//             ];
//           },
//           body: const TabView(),
//         ),
//         floatingActionButton: SpeedDial(
//           overlayOpacity: 0,
//           iconTheme: const IconThemeData(color: AppColors.whiteColor),
//           direction: SpeedDialDirection.left,
//           tooltip: 'Options',
//           childrenButtonSize: const Size(56.0, 56.0),
//           buttonSize: const Size(50.0, 50.0),
//           shape: const CircleBorder(),
//           icon: Icons.more_horiz,
//           activeIcon: Icons.more_horiz,
//           activeBackgroundColor: Theme.of(context).colorScheme.secondaryFixed,
//           backgroundColor: Theme.of(context).primaryColor,
//           children: [
//             SpeedDialChild(
//               backgroundColor: Theme.of(context).colorScheme.error,
//               shape: const CircleBorder(),
//               child: const Icon(Icons.close, color: AppColors.whiteColor),
//               onTap: () => {showCloseConfirmation()},
//             ),
//             SpeedDialChild(
//               backgroundColor: Theme.of(context).primaryColor,
//               shape: const CircleBorder(),
//               child: const Icon(
//                 Icons.settings,
//                 color: AppColors.whiteColor,
//               ),
//               onTap: () => {showSettings()},
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget collapsedWidget() {
//     return Container(
//       color: Theme.of(context).colorScheme.surfaceTint,
//       alignment: Alignment.center,
//       padding: EdgeInsets.only(top: 0),
//       height: 200,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 width: collapsedCircleWidth,
//                 height: collapsedCircleWidth,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.transparent,
//                 ),
//                 child: timeTicker(Colors.transparent),
//               ),
//               Container(
//                 height: collapsedCircleWidth,
//                 width: collapsedCircleWidth,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Theme.of(context).colorScheme.surface,
//                 ),
//                 child: playerImageViewSmall(),
//               ),
//               Container(
//                   height: collapsedCircleWidth,
//                   width: collapsedCircleWidth,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.blackColor,
//                   ),
//                   child: pointsViewSmall(
//                     SvgPicture.asset(AppImages.leagueIcon),
//                     Text(
//                       "Mapple",
//                       style: TextStyle(
//                           color: Theme.of(context).colorScheme.secondaryFixed,
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//               Container(
//                   height: collapsedCircleWidth,
//                   width: collapsedCircleWidth,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.blackColor,
//                   ),
//                   child: pointsViewSmall(
//                     const Text(
//                       "Points",
//                       style:
//                       TextStyle(color: AppColors.whiteColor, fontSize: 9),
//                     ),
//                     const Text(
//                       "2000",
//                       style: TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 13,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   )),
//             ],
//           ),
//           InkWell(
//             onTap: () {
//               if (isBidEnabled) {
//                 Confetti.launch(
//                   context,
//                   options: const ConfettiOptions(
//                       decay: .7,
//                       drift: 0,
//                       gravity: 1.5,
//                       angle: 90,
//                       particleCount: 200,
//                       spread: 100,
//                       y: 0.4,
//                       x: .5),
//                 );
//               }
//               setState(() {
//                 isBidEnabled = !isBidEnabled;
//               });
//             },
//             child: Opacity(
//               opacity: isBidEnabled ? 1.0 : .2,
//               child: Container(
//                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//                 margin: const EdgeInsets.only(top: 10, bottom: 10),
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.primary,
//                     borderRadius: BorderRadius.circular(30)),
//                 alignment: Alignment.center,
//                 width: screenWidth * .7,
//                 child: const Text(
//                   "Bid - 2000",
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.whiteColor),
//                 ),
//               ),
//             ),
//           ),
//           Container(
//             width: screenWidth * .74,
//             padding: const EdgeInsets.only(bottom: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 RichText(
//                     textAlign: TextAlign.left,
//                     text: TextSpan(
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Lufga',
//                           color: Theme.of(context).colorScheme.surfaceDim,
//                         ),
//                         children: const [
//                           TextSpan(text: "My Balance"),
//                           TextSpan(
//                               text: "\n5000",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 15)),
//                         ])),
//                 RichText(
//                     textAlign: TextAlign.center,
//                     text: TextSpan(
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontFamily: 'Lufga',
//                           fontWeight: FontWeight.w500,
//                           color: Theme.of(context).colorScheme.surfaceDim,
//                         ),
//                         children: const [
//                           TextSpan(text: "Max Bid Points"),
//                           TextSpan(
//                               text: "\n2000",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 15)),
//                         ])),
//                 RichText(
//                     textAlign: TextAlign.right,
//                     text: TextSpan(
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontFamily: 'Lufga',
//                           fontWeight: FontWeight.w500,
//                           color: Theme.of(context).colorScheme.surfaceDim,
//                         ),
//                         children: const [
//                           TextSpan(text: "My Players"),
//                           TextSpan(
//                               text: "\n5/10",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 15)),
//                         ])),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget expandedWidget() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           height: appBarHeight+screenHeight*.06,
//           width: screenWidth,
//           color: Theme.of(context).colorScheme.primary,
//         ),
//         Stack(
//           children: [
//             Container(
//               height: 400,
//               color: Colors.transparent,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Positioned(top: 50, child: playerImageView()),
//                   Positioned(bottom: 0,child: pointDetailsView()),
//                   Positioned(
//                     top: screenWidth * .5,
//                     right: screenWidth * .16,
//                     child: SvgPicture.asset(
//                       AppImages.bookmarkBadge,
//                       width: screenWidth * .12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Container(
//                   height: 60,
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.primary,
//                       borderRadius: const BorderRadius.only(
//                           bottomRight: Radius.circular(30),
//                           bottomLeft: Radius.circular(30))),
//                   width: screenWidth,
//                   padding: const EdgeInsets.only(
//                       left: 20, right: 20, top: 0, bottom: 10),
//                   child: playersSummary(),
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   child: Container(
//                     alignment: Alignment.center,
//                     color: Colors.transparent,
//                     width: curveWith + largeCircleWidth + curveWith,
//                     height: largeCircleWidth /2,
//                     child: Stack(
//                       alignment: Alignment.bottomCenter,
//                       children: [
//                         Positioned(
//                           left: curveWith ,
//                           bottom: 0,
//                           child: Container(
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).colorScheme.surface,
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(largeCircleWidth /2),
//                                 topRight: Radius.circular(largeCircleWidth /2),
//                               ),
//                             ),
//                             width: largeCircleWidth ,
//                             height: largeCircleWidth /2,
//                           ),
//
//                         ),
//                         Positioned(
//                           bottom: -12,
//                           right: curveWith + largeCircleWidth -15,
//                           child: Transform(
//                             transform: Matrix4.identity()..scale(-1.0, 1.0),
//                             alignment: Alignment.center,
//                             child: SvgPicture.asset(
//                               AppImages.rightCurve,
//                               colorFilter: ColorFilter.mode(
//                                 Theme.of(context).colorScheme.surface,
//                                 BlendMode.srcIn,
//                               ),
//                               width: curveWith,
//                               height: largeCircleWidth * .5,
//                               fit: BoxFit.fitWidth,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                             bottom: -12,
//                             left: curveWith + largeCircleWidth -15,
//                             child: SvgPicture.asset(
//                               colorFilter: ColorFilter.mode(
//                                 Theme.of(context).colorScheme.surface,
//                                 BlendMode.srcIn,
//                               ),
//                               height: largeCircleWidth * .5,
//                               AppImages.rightCurve,
//                               width: curveWith,
//                               fit: BoxFit.fitWidth,
//                             )),
//                       ],
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//             Positioned(
//               top: 20,
//               left: (screenWidth/2)- (largeCircleWidth * .9/2),
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.surface,
//                       shape: BoxShape.circle,
//                     ),
//                     width: largeCircleWidth * .9,
//                     height: largeCircleWidth * .9,
//                   ),
//                   timeTicker(Theme.of(context).colorScheme.surface),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         Stack(
//           children: [
//             Container(
//               height: 240,
//               alignment: Alignment.bottomCenter,
//               padding: const EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.surface,
//                   border:
//                   Border.all(color: Theme.of(context).colorScheme.primary),
//                   borderRadius: const BorderRadius.only(
//                       bottomRight: Radius.circular(40),
//                       bottomLeft: Radius.circular(40))),
//               child: currentBalanceSummary(),
//             ),
//             InkWell(
//               onTap: () {
//                 if (isBidEnabled) {
//                   Confetti.launch(context,
//                       options: const ConfettiOptions(
//                           decay: .7,
//                           drift: 0,
//                           gravity: 1.5,
//                           angle: 90,
//                           particleCount: 200,
//                           spread: 50,
//                           y: 0.5,
//                           x: .5));
//                 }
//                 setState(() {
//                   isBidEnabled = !isBidEnabled;
//                 });
//               },
//               child: Container(
//                 height: 200,
//                 padding: const EdgeInsets.all(4),
//                 alignment: Alignment.bottomCenter,
//                 width: screenWidth,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.surfaceTint,
//                     borderRadius: const BorderRadius.only(
//                         bottomRight: Radius.circular(40),
//                         bottomLeft: Radius.circular(40))),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Opacity(
//                       opacity: isBidEnabled ? 1.0 : .2,
//                       child: Container(
//                         padding: const EdgeInsets.only(top: 8, bottom: 8),
//                         margin: const EdgeInsets.only(top: 10),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                                 width: 1,
//                                 color: Theme.of(context).colorScheme.primary),
//                             color: Theme.of(context).colorScheme.primary,
//                             borderRadius: BorderRadius.circular(30)),
//                         alignment: Alignment.center,
//                         width: screenWidth * .8,
//                         child: const Text(
//                           "Bid - 2000",
//                           style: TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.whiteColor),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 6,
//                     ),
//                     RichText(
//                       text: TextSpan(
//                         style: Theme.of(context).textTheme.bodyLarge,
//                         children: [
//                           TextSpan(
//                               text: 'Max bid point: ',
//                               style: TextStyle(
//                                   color:
//                                   Theme.of(context).colorScheme.surfaceDim)),
//                           const TextSpan(
//                             text: '5000',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               height: 100,
//               alignment: Alignment.bottomCenter,
//               padding:
//               const EdgeInsets.only(bottom: 10, left: 15, right: 15, top: 0),
//               decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.surface,
//                   // color: Colors.yellow,
//                   borderRadius: const BorderRadius.only(
//                       bottomRight: Radius.circular(40),
//                       bottomLeft: Radius.circular(40))),
//               child: playerDetails(),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget topSection() {
//     return SizedBox(
//       width: screenWidth,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Stack(
//             children: [
//               Image.asset(
//                 AppImages.playerDefaultImage,
//                 height: screenWidth * .1,
//                 width: screenWidth * .1,
//               ),
//               Positioned(
//                 right: 02,
//                 top: 02,
//                 child: Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.surfaceBright,
//                     shape: BoxShape.circle,
//                   ),
//                   constraints: const BoxConstraints(
//                     minWidth: 10,
//                     minHeight: 10,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Text(
//             "Mapple Premier League",
//             style: TextStyle(
//                 color: AppColors.whiteColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500),
//           ),
//           Container(
//             padding:
//             const EdgeInsets.only(top: 2, left: 12, right: 12, bottom: 2),
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               border: Border.all(
//                   color: Theme.of(context).colorScheme.surfaceBright,
//                   width: 1.5),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Text(
//               'Live',
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.surfaceBright,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget playersSummary() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             playersInfoCard("200", "Total Players"),
//             playersInfoCard("130", "Sold Players"),
//           ],
//         ),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             playersInfoCard("67", "Total Players"),
//             playersInfoCard("3", "Unsold Players"),
//           ],
//         )
//       ],
//     );
//   }
//
//   Widget timeTicker(Color backgroundColor) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             color: backgroundColor,
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: Theme.of(context).colorScheme.primary,
//               width: 1,
//             ),
//           ),
//           width: largeCircleWidth * .8,
//           height: largeCircleWidth * .8,
//         ),
//         Stack(
//           children: [
//             CircularCountDownTimer(
//               duration: 60,
//               initialDuration: 0,
//               controller: _controller,
//               width: largeCircleWidth * .6,
//               height: largeCircleWidth * .6,
//               ringColor: AppColors.darkGrey,
//               fillColor: Theme.of(context).colorScheme.tertiary,
//               backgroundColor: backgroundColor,
//               strokeWidth: 5,
//               strokeCap: StrokeCap.square,
//               textStyle: TextStyle(
//                 fontSize: 20,
//                 color: Theme.of(context).colorScheme.surfaceDim,
//                 fontWeight: FontWeight.bold,
//               ),
//               textFormat: CountdownTextFormat.S,
//               isTimerTextShown: true,
//               isReverseAnimation: true,
//               isReverse: true,
//               autoStart: true,
//             ),
//             Positioned(
//               top: largeCircleWidth * .35,
//               child: Container(
//                 alignment: Alignment.bottomCenter,
//                 width: largeCircleWidth * .6,
//                 height: 16,
//                 color: Colors.transparent,
//                 child: const Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Text(
//                       "Sec",
//                       style: TextStyle(fontSize: 10),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
//
//   Widget playerImageView() {
//     return Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(10),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Medium circle inside the largest one
//             Container(
//               width: screenWidth * .76,
//               height: screenWidth * .76,
//               decoration: BoxDecoration(
//                 color: Colors.black12,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.primary10,
//                   width: 1,
//                 ),
//               ),
//             ),
//             // Smallest circle inside the medium one
//             Container(
//               width: screenWidth * .69,
//               height: screenWidth * .69,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.surfaceTint,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.primary36,
//                   width: 25,
//                 ),
//               ),
//             ),
//             Container(
//               width: screenWidth * .6,
//               height: screenWidth * .6,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.primary,
//                 shape: BoxShape.circle,
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Image.asset(AppImages.playerImage),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget playerImageViewSmall() {
//     return Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(3),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Medium circle inside the largest one
//             Container(
//               width: collapsedCircleWidth,
//               height: collapsedCircleWidth,
//               decoration: const BoxDecoration(
//                 color: Colors.black12,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             // Smallest circle inside the medium one
//             Container(
//               width: collapsedCircleWidth * .8,
//               height: collapsedCircleWidth * .8,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.primary,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: Theme.of(context).colorScheme.surfaceTint,
//                   width: 5,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(3),
//                 child: Image.asset(
//                   AppImages.playerImage,
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget pointDetailsView() {
//     return Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.all(10),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               width: screenWidth * .3,
//               height: screenWidth * .3,
//               decoration: BoxDecoration(
//                 color: Colors.transparent,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.brightYellow,
//                   width: .5,
//                 ),
//               ),
//             ),
//             // Largest circle
//             Container(
//               width: screenWidth * .25,
//               height: screenWidth * .25,
//               decoration: const BoxDecoration(
//                 color: AppColors.blackColor,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             // Medium circle inside the largest one
//             Container(
//               width: screenWidth * .21,
//               height: screenWidth * .21,
//               decoration: BoxDecoration(
//                 color: AppColors.blackColor,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.brightYellow,
//                   width: .5,
//                 ),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(14),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Points",
//                       style:
//                       TextStyle(color: AppColors.whiteColor, fontSize: 13),
//                     ),
//                     Text(
//                       "2000",
//                       style: TextStyle(
//                           color: AppColors.whiteColor,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget pointsViewSmall(Widget topWidget, Widget bottomWidget) {
//     return Container(
//         alignment: Alignment.center,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               width: collapsedCircleWidth,
//               height: collapsedCircleWidth,
//               decoration: const BoxDecoration(
//                 color: AppColors.blackColor,
//                 shape: BoxShape.circle,
//               ),
//             ),
//             // Medium circle inside the largest one
//             Container(
//               width: collapsedCircleWidth * .8,
//               height: collapsedCircleWidth * .8,
//               decoration: BoxDecoration(
//                 color: AppColors.blackColor,
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: AppColors.brightYellow,
//                   width: .5,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(6),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     topWidget,
//                     bottomWidget,
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }
//
//   Widget playerDetails() {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.end,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           "Gurup Wamsi Kumar(Guru)",
//           style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: Theme.of(context).colorScheme.surfaceDim),
//         ),
//         RichText(
//           text: TextSpan(
//             style: TextStyle(
//                 fontSize: 18, color: Theme.of(context).colorScheme.surfaceDim),
//             children: [
//               const TextSpan(text: '32y old, '),
//               TextSpan(
//                 text: 'Striker',
//                 style: TextStyle(
//                     color: Theme.of(context).colorScheme.surfaceDim,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.only(left: 0, right: 0),
//           width: screenWidth,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               infoCard("Wicketkeeper", "25"),
//               infoCard("Bowler", "12"),
//               infoCard("All-rounder", "13"),
//               infoCard("Finisher", "2"),
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   Widget currentBalanceSummary() {
//     return Container(
//       width: screenWidth,
//       padding: const EdgeInsets.only(left: 20, right: 20, ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           RichText(
//             text: TextSpan(
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyLarge
//                   ?.apply(color: Theme.of(context).colorScheme.surfaceDim),
//               children: const [
//                 TextSpan(text: 'My balance: '),
//                 TextSpan(
//                   text: '1800',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//           RichText(
//             text: TextSpan(
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyLarge
//                   ?.apply(color: Theme.of(context).colorScheme.surfaceDim),
//               children: const [
//                 TextSpan(text: 'My players: '),
//                 TextSpan(
//                   text: '5/10',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget playersInfoCard(String count, String label) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(
//           count,
//           style: const TextStyle(
//               color: AppColors.whiteColor,
//               fontSize: 15,
//               fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(
//           width: 10,
//         ),
//         Text(
//           label,
//           style: const TextStyle(
//               color: AppColors.whiteColor,
//               fontSize: 13,
//               fontWeight: FontWeight.normal),
//         ),
//       ],
//     );
//   }
//
//   Widget infoCard(String label, String count) {
//     return Stack(
//       children: [
//         Container(
//           padding: const EdgeInsets.only(top: 8, right: 5),
//           child: Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(15),
//                 color: Theme.of(context).colorScheme.primaryFixed),
//             margin: const EdgeInsets.only(
//               left: 2,
//             ),
//             padding:
//             const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 8),
//             child: Text(
//               label,
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.surface, fontSize: 13),
//             ),
//           ),
//         ),
//         Positioned(
//           right: 0,
//           top: 0,
//           child: Container(
//             padding: const EdgeInsets.all(0),
//             decoration: const BoxDecoration(
//               color: AppColors.lightPurple10,
//               shape: BoxShape.circle,
//             ),
//             constraints: const BoxConstraints(
//               minWidth: 16,
//               minHeight: 16,
//             ),
//             child: Text(
//               count,
//               style: TextStyle(
//                 color: Theme.of(context).colorScheme.primary,
//                 fontSize: 10,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget auctionTopBar() {
//     return ClipRRect(
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       borderRadius: const BorderRadius.only(
//           bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
//       child: AppBar(
//         centerTitle: false,
//         titleSpacing: 0,
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//         title: Container(
//           padding: const EdgeInsets.only(right: 20, left: 20),
//           decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.secondary,
//               borderRadius: const BorderRadius.only(
//                   bottomRight: Radius.circular(40),
//                   bottomLeft: Radius.circular(40))),
//           child: topSection(),
//         ),
//       ),
//     );
//   }
//
//   void showContactDetails(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (BuildContext context) {
//         return Container(
//             width: screenWidth,
//             padding: const EdgeInsets.all(16),
//             child: Container(
//               width: screenWidth,
//               height: 400,
//               padding: const EdgeInsets.only(
//                   left: 10, right: 10, top: 10, bottom: 10),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Select Date & Time",
//                     style: Theme.of(context).textTheme.titleMedium,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: 20,
//                       itemBuilder: (context, index) {
//                         return contactCard();
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }
//
//   Widget contactCard() {
//     return Container(
//       margin: const EdgeInsets.only(
//         bottom: 8,
//         left: 2,
//       ),
//       width: MediaQuery.of(context).size.width,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//           color: Theme.of(context).colorScheme.surface,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//               width: 1, color: Theme.of(context).colorScheme.outline)),
//       child: Row(
//         mainAxisSize: MainAxisSize.max,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           RichText(
//               textAlign: TextAlign.left,
//               text: TextSpan(
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Lufga',
//                     color: Theme.of(context).colorScheme.surfaceDim,
//                   ),
//                   children: [
//                     const TextSpan(
//                       text: "Suresh",
//                     ),
//                     TextSpan(
//                         text: "\n+91 9182726356",
//                         style: TextStyle(
//                             fontWeight: FontWeight.normal,
//                             fontSize: 16,
//                             color: Theme.of(context).colorScheme.surfaceDim)),
//                   ])),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               CircleAvatar(
//                 radius: 22, // Size of the circle
//                 backgroundColor: Theme.of(context)
//                     .colorScheme
//                     .surface, // Circle background color
//                 child: Icon(
//                   Icons.copy, // Icon you want inside the circle
//                   color: Theme.of(context).colorScheme.surfaceDim, // Icon color
//                   size: 24, // Icon size
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               CircleAvatar(
//                 radius: 22, // Size of the circle
//                 backgroundColor: Theme.of(context)
//                     .colorScheme
//                     .primary, // Circle background color
//                 child: const Icon(
//                   Icons.call, // Icon you want inside the circle
//                   color: Colors.white, // Icon color
//                   size: 24, // Icon size
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   DateTime? _selectedDate;
//   DateTime? _selectedDate2;
//   TimeOfDay? _selectedTime;
//
//   showSettings() {
//     bool isAutoSwitched = true;
//     bool isStopSwitched = true;
//     bool isStopSwitchActive = true;
//     bool auctionLive = true;
//     String? selectedValue;
//
//     final List<String> items = [
//       'All Franchaises are not online',
//       'Reason 2',
//       'Reason 3'
//     ];
//
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(25.0), // Rounded top corners
//         ),
//       ),
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       builder: (context) {
//         return StatefulBuilder(
//           // Needed to manage state inside the bottom sheet
//           builder: (context, setModalState) {
//             Widget auctionTabView() {
//               return Column(
//                 children: [
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(
//                         left: 10, right: 10, top: 10, bottom: 10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: Theme.of(context).colorScheme.outline,
//                             width: 1)),
//                     width: screenWidth,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               "Auto Pause",
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Opacity(
//                                 opacity: .2,
//                                 child: Icon(
//                                   Icons.info,
//                                   color:
//                                   Theme.of(context).colorScheme.surfaceDim,
//                                   size: 15,
//                                 ))
//                           ],
//                         ),
//                         Switch(
//                           inactiveThumbColor: AppColors.outlineDark,
//                           value: isAutoSwitched,
//                           onChanged: (value) {
//                             setModalState(() {
//                               isAutoSwitched = value;
//                             });
//                             setState(() {
//                               isAutoSwitched = value;
//                             });
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Container(
//                     padding: const EdgeInsets.only(
//                         left: 10, right: 10, top: 10, bottom: 10),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: Theme.of(context).colorScheme.outline,
//                             width: 1)),
//                     width: screenWidth,
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               "Stop Auction",
//                               style: Theme.of(context).textTheme.titleMedium,
//                             ),
//                             Switch(
//                               activeTrackColor: isStopSwitchActive
//                                   ? Theme.of(context).colorScheme.primary
//                                   : Theme.of(context).colorScheme.outline,
//                               // activeTrack: Theme.of(context).colorScheme.surface,
//                               value: isStopSwitched,
//                               onChanged: (value) {
//                                 isStopSwitchActive
//                                     ? {
//                                   setModalState(() {
//                                     isStopSwitched = value;
//                                   }),
//                                   setState(() {
//                                     isStopSwitched = value;
//                                   })
//                                 }
//                                     : null;
//                               },
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         auctionLive
//                             ? Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Reason",
//                             ),
//                             Container(
//                               width: screenWidth * .5,
//                               padding: const EdgeInsets.all(0),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .outline,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: DropdownButtonFormField<String>(
//                                 padding: EdgeInsets.zero,
//                                 value: selectedValue,
//                                 decoration: InputDecoration(
//                                   enabledBorder: InputBorder.none,
//                                   focusedBorder: InputBorder.none,
//                                   contentPadding:
//                                   const EdgeInsets.symmetric(
//                                       vertical: 0, horizontal: 12),
//                                   border: OutlineInputBorder(
//                                       borderSide: BorderSide(
//                                         width: .6,
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .outline,
//                                       ),
//                                       borderRadius:
//                                       BorderRadius.circular(8)),
//                                 ),
//                                 hint: const Text('Select'),
//                                 isExpanded: true,
//                                 isDense: true,
//                                 items: [
//                                   DropdownMenuItem<String>(
//                                     value: null,
//                                     child: Container(
//                                       alignment: Alignment.centerLeft,
//                                       height: 16,
//                                       child: const Text(
//                                         'Select',
//                                         style:
//                                         TextStyle(color: Colors.grey),
//                                       ),
//                                     ),
//                                   ),
//                                   ...items.map(
//                                           (item) => DropdownMenuItem<String>(
//                                         value: item,
//                                         child: Container(
//                                             alignment:
//                                             Alignment.centerLeft,
//                                             height: 16,
//                                             child: Text(item)),
//                                       )),
//                                 ],
//                                 onChanged: (String? newValue) {
//                                   setState(() {
//                                     selectedValue = newValue;
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         )
//                             : Container(
//                           padding: const EdgeInsets.only(
//                               top: 10, bottom: 10, left: 20, right: 20),
//                           margin:
//                           const EdgeInsets.only(top: 10, bottom: 10),
//                           decoration: BoxDecoration(
//                               color:
//                               Theme.of(context).colorScheme.secondary,
//                               borderRadius: BorderRadius.circular(30)),
//                           alignment: Alignment.center,
//                           width: screenWidth * .6,
//                           child: Row(
//                             mainAxisAlignment:
//                             MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text(
//                                 "10 June",
//                                 style: TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.normal,
//                                     color: AppColors.whiteColor),
//                               ),
//                               Countdown(
//                                 seconds: 1000,
//                                 build: (_, double time) {
//                                   int hours = (time / 3600)
//                                       .floor(); // Extract hours
//                                   int minutes = ((time % 3600) / 60)
//                                       .floor(); // Extract minutes
//                                   int seconds = (time % 60)
//                                       .floor(); // Extract seconds
//
//                                   return Text(
//                                     "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
//                                     style: const TextStyle(
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.bold,
//                                         color: AppColors.whiteColor),
//                                   );
//                                 },
//                                 onFinished: () => {},
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         auctionLive
//                             ? Row(
//                           mainAxisAlignment:
//                           MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               "Set Time",
//                             ),
//                             Container(
//                               width: screenWidth * .5,
//                               height: 30,
//                               alignment: Alignment.centerRight,
//                               padding: const EdgeInsets.all(0),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .primary,
//                                 ),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   DateTime? picked = await showDatePicker(
//                                     context: context,
//                                     initialDate:
//                                     _selectedDate ?? DateTime.now(),
//                                     firstDate: DateTime(2000),
//                                     lastDate: DateTime(2101),
//                                     initialEntryMode:
//                                     DatePickerEntryMode.calendarOnly,
//                                     builder: (BuildContext context,
//                                         Widget? child) {
//                                       return Theme(
//                                         data: Theme.of(context).copyWith(
//                                           datePickerTheme:
//                                           DatePickerThemeData(
//                                             backgroundColor:
//                                             Theme.of(context)
//                                                 .colorScheme
//                                                 .surface,
//                                             headerHelpStyle:
//                                             const TextStyle(
//                                               fontSize: 18,
//                                               fontWeight:
//                                               FontWeight.normal,
//                                             ),
//                                           ),
//                                         ),
//                                         child: child!,
//                                       );
//                                     },
//                                   );
//
//                                   if (picked != null) {
//                                     setModalState(() {
//                                       _selectedDate = picked;
//                                     });
//                                     if (_selectedDate != null) {
//                                       DateTime initialTime =
//                                       DateTime.now();
//                                       showModalBottomSheet(
//                                         context: context,
//                                         builder: (BuildContext context) {
//                                           DateTime pickedTime =
//                                               initialTime;
//                                           return SizedBox(
//                                             height: 250,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                               children: [
//                                                 Container(
//                                                   margin: const EdgeInsets
//                                                       .all(20),
//                                                   child: Row(
//                                                     mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                     children: [
//                                                       Text(
//                                                         "Select Time",
//                                                         style: Theme.of(
//                                                             context)
//                                                             .textTheme
//                                                             .titleMedium,
//                                                       ),
//                                                       TextButton(
//                                                         style: TextButton
//                                                             .styleFrom(
//                                                           foregroundColor:
//                                                           Colors
//                                                               .white,
//                                                           backgroundColor:
//                                                           Theme.of(
//                                                               context)
//                                                               .colorScheme
//                                                               .primary,
//                                                           // Button background color
//                                                           textStyle: Theme.of(
//                                                               context)
//                                                               .textTheme
//                                                               .titleSmall,
//                                                           // Text style
//                                                           padding: const EdgeInsets
//                                                               .symmetric(
//                                                               vertical: 0,
//                                                               horizontal:
//                                                               0),
//                                                           // Padding
//                                                           shape: RoundedRectangleBorder(
//                                                               borderRadius:
//                                                               BorderRadius.circular(
//                                                                   20)), // Button shape
//                                                         ),
//                                                         child: const Text(
//                                                             "Done"),
//                                                         onPressed:
//                                                             () async {
//                                                           setModalState(
//                                                                   () {
//                                                                 _selectedTime =
//                                                                     TimeOfDay
//                                                                         .fromDateTime(
//                                                                         pickedTime);
//                                                               });
//                                                           if (_selectedTime !=
//                                                               null) {
//                                                             setModalState(
//                                                                     () {
//                                                                   _selectedDate2 =
//                                                                       DateTime(
//                                                                         _selectedDate!
//                                                                             .year,
//                                                                         _selectedDate!
//                                                                             .month,
//                                                                         _selectedDate!
//                                                                             .day,
//                                                                         _selectedTime!
//                                                                             .hour,
//                                                                         _selectedTime!
//                                                                             .minute,
//                                                                       );
//                                                                 });
//                                                             // await getFormattedDateTime(_selectedDate2, _selectedTime);
//                                                             //
//                                                           }
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                                 Expanded(
//                                                   child:
//                                                   CupertinoDatePicker(
//                                                     mode:
//                                                     CupertinoDatePickerMode
//                                                         .time,
//                                                     initialDateTime:
//                                                     initialTime,
//                                                     use24hFormat: false,
//                                                     onDateTimeChanged:
//                                                         (DateTime time) {
//                                                       setModalState(() {
//                                                         pickedTime = time;
//                                                       });
//                                                     },
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         },
//                                       );
//                                     }
//                                   }
//                                 },
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       _selectedDate2 == null
//                                           ? '---'
//                                           : DateFormat('MMMM d, y')
//                                           .format(_selectedDate2!),
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium,
//                                     ),
//                                     Container(
//                                       height: 30,
//                                       width: screenWidth * .2,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                             width: .5),
//                                         borderRadius:
//                                         BorderRadius.circular(8),
//                                       ),
//                                       child: Text(
//                                         _selectedDate2 == null
//                                             ? '---'
//                                             : DateFormat('hh:mm a')
//                                             .format(_selectedDate2!),
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                             : Text("Reason: ${selectedValue ?? ""}"),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   auctionLive
//                       ? InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         builder: (BuildContext context) {
//                           return Wrap(
//                             children: [
//                               Container(
//                                 width: screenWidth,
//                                 padding: const EdgeInsets.only(
//                                     left: 10,
//                                     right: 10,
//                                     top: 10,
//                                     bottom: 10),
//                                 child: Column(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.end,
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.end,
//                                   children: [
//                                     InkWell(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Icon(Icons.close,
//                                             size: 30,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .surfaceDim)),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.center,
//                                       children: [
//                                         SvgPicture.asset(
//                                           AppImages.alertSign,
//                                           width: 50,
//                                           height: 50,
//                                           colorFilter: ColorFilter.mode(
//                                             isDarkMode ? DarkColors.notificationOrange : LightColors.notificationOrange,
//                                             BlendMode.srcIn,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         const Text(
//                                           "Do you want to STOP this auction?",
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               fontSize: 24,
//                                               fontWeight:
//                                               FontWeight.bold),
//                                         ),
//                                         const SizedBox(
//                                           height: 20,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment
//                                               .spaceBetween,
//                                           children: [
//                                             InkWell(
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 10,
//                                                     bottom: 10),
//                                                 margin:
//                                                 const EdgeInsets.only(
//                                                     top: 10,
//                                                     bottom: 10,
//                                                     left: 10,
//                                                     right: 10),
//                                                 decoration: BoxDecoration(
//                                                     border: Border.all(
//                                                         color: Theme.of(
//                                                             context)
//                                                             .colorScheme
//                                                             .primary),
//                                                     color:
//                                                     Theme.of(context)
//                                                         .colorScheme
//                                                         .surface,
//                                                     borderRadius:
//                                                     BorderRadius
//                                                         .circular(
//                                                         30)),
//                                                 alignment:
//                                                 Alignment.center,
//                                                 width: screenWidth * .35,
//                                                 child: Text(
//                                                   "Cancel",
//                                                   style: Theme.of(context)
//                                                       .textTheme
//                                                       .titleLarge,
//                                                 ),
//                                               ),
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 setModalState(() {
//                                                   auctionLive = false;
//                                                   isStopSwitchActive =
//                                                   false;
//                                                 });
//                                                 Navigator.pop(context);
//                                               },
//                                               child: Container(
//                                                 padding:
//                                                 const EdgeInsets.only(
//                                                     top: 10,
//                                                     bottom: 10),
//                                                 margin:
//                                                 const EdgeInsets.only(
//                                                     top: 10,
//                                                     bottom: 10,
//                                                     left: 10,
//                                                     right: 10),
//                                                 decoration: BoxDecoration(
//                                                     color:
//                                                     Theme.of(context)
//                                                         .colorScheme
//                                                         .primary,
//                                                     borderRadius:
//                                                     BorderRadius
//                                                         .circular(
//                                                         30)),
//                                                 alignment:
//                                                 Alignment.center,
//                                                 width: screenWidth * .35,
//                                                 child: const Text(
//                                                     "Yes, stop",
//                                                     style: TextStyle(
//                                                         fontSize: 16,
//                                                         fontWeight:
//                                                         FontWeight
//                                                             .bold,
//                                                         color: AppColors
//                                                             .whiteColor)),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 30,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Opacity(
//                       opacity: isBidEnabled ? 1.0 : .2,
//                       child: Container(
//                         padding:
//                         const EdgeInsets.only(top: 10, bottom: 10),
//                         margin:
//                         const EdgeInsets.only(top: 10, bottom: 10),
//                         decoration: BoxDecoration(
//                             color: Theme.of(context).colorScheme.primary,
//                             borderRadius: BorderRadius.circular(30)),
//                         alignment: Alignment.center,
//                         width: screenWidth * .7,
//                         child: const Text(
//                           "Stop Auction",
//                           style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.whiteColor),
//                         ),
//                       ),
//                     ),
//                   )
//                       : Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: () {},
//                         child: Container(
//                           padding:
//                           const EdgeInsets.only(top: 10, bottom: 10),
//                           margin:
//                           const EdgeInsets.only(top: 10, bottom: 10),
//                           decoration: BoxDecoration(
//                               border: Border.all(
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .primary),
//                               color:
//                               Theme.of(context).colorScheme.surface,
//                               borderRadius: BorderRadius.circular(30)),
//                           alignment: Alignment.center,
//                           width: screenWidth * .35,
//                           child: Text(
//                             "Update",
//                             style: Theme.of(context).textTheme.titleLarge,
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (BuildContext context) {
//                               return Wrap(
//                                 children: [
//                                   Container(
//                                     width: screenWidth,
//                                     padding: const EdgeInsets.only(
//                                         left: 10,
//                                         right: 10,
//                                         top: 10,
//                                         bottom: 10),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.end,
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.end,
//                                       children: [
//                                         InkWell(
//                                             onTap: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Icon(Icons.close,
//                                                 size: 30,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .surfaceDim)),
//                                         const SizedBox(
//                                           height: 10,
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                           children: [
//                                             SvgPicture.asset(
//                                               AppImages.alertSign,
//                                               width: 50,
//                                               height: 50,
//                                               colorFilter:
//                                               ColorFilter.mode(
//                                                 isDarkMode ? DarkColors.notificationOrange : LightColors.notificationOrange,
//                                                 BlendMode.srcIn,
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             Container(
//                                                 width: screenWidth * .7,
//                                                 padding:
//                                                 const EdgeInsets.all(
//                                                     10),
//                                                 decoration: BoxDecoration(
//                                                     color: isDarkMode ? DarkColors.highlightYellow : LightColors.highlightYellow,
//                                                     borderRadius:
//                                                     BorderRadius
//                                                         .circular(
//                                                         20)),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .center,
//                                                   crossAxisAlignment:
//                                                   CrossAxisAlignment
//                                                       .center,
//                                                   children: [
//                                                     SvgPicture.asset(
//                                                       AppImages
//                                                           .alertSign2,
//                                                       width: 24,
//                                                       height: 24,
//                                                       colorFilter:
//                                                       ColorFilter
//                                                           .mode(
//                                                         Theme.of(context)
//                                                             .colorScheme
//                                                             .surfaceDim,
//                                                         BlendMode.srcIn,
//                                                       ),
//                                                     ),
//                                                     const SizedBox(
//                                                       width: 10,
//                                                     ),
//                                                     Text(
//                                                       "2 franchises are offline",
//                                                       style: Theme.of(
//                                                           context)
//                                                           .textTheme
//                                                           .titleMedium,
//                                                     ),
//                                                   ],
//                                                 )),
//                                             const SizedBox(
//                                               height: 10,
//                                             ),
//                                             const Text(
//                                               "Do you want to RESUME this auction?",
//                                               textAlign: TextAlign.center,
//                                               style: TextStyle(
//                                                   fontSize: 24,
//                                                   fontWeight:
//                                                   FontWeight.bold),
//                                             ),
//                                             const SizedBox(
//                                               height: 20,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment
//                                                   .spaceBetween,
//                                               children: [
//                                                 InkWell(
//                                                   onTap: () {
//                                                     Navigator.pop(
//                                                         context);
//                                                   },
//                                                   child: Container(
//                                                     padding:
//                                                     const EdgeInsets
//                                                         .only(
//                                                         top: 10,
//                                                         bottom: 10),
//                                                     margin:
//                                                     const EdgeInsets
//                                                         .only(
//                                                         top: 10,
//                                                         bottom: 10,
//                                                         left: 10,
//                                                         right: 10),
//                                                     decoration: BoxDecoration(
//                                                         border: Border.all(
//                                                             color: Theme.of(
//                                                                 context)
//                                                                 .colorScheme
//                                                                 .primary),
//                                                         color: Theme.of(
//                                                             context)
//                                                             .colorScheme
//                                                             .surface,
//                                                         borderRadius:
//                                                         BorderRadius
//                                                             .circular(
//                                                             30)),
//                                                     alignment:
//                                                     Alignment.center,
//                                                     width:
//                                                     screenWidth * .35,
//                                                     child: Text(
//                                                       "Cancel",
//                                                       style: Theme.of(
//                                                           context)
//                                                           .textTheme
//                                                           .titleLarge,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 InkWell(
//                                                   onTap: () {
//                                                     setModalState(() {
//                                                       auctionLive = true;
//                                                       isStopSwitchActive =
//                                                       true;
//                                                     });
//                                                     Navigator.pop(
//                                                         context);
//                                                   },
//                                                   child: Container(
//                                                     padding:
//                                                     const EdgeInsets
//                                                         .only(
//                                                         top: 10,
//                                                         bottom: 10),
//                                                     margin:
//                                                     const EdgeInsets
//                                                         .only(
//                                                         top: 10,
//                                                         bottom: 10,
//                                                         left: 10,
//                                                         right: 10),
//                                                     decoration: BoxDecoration(
//                                                         color: Theme.of(
//                                                             context)
//                                                             .colorScheme
//                                                             .primary,
//                                                         borderRadius:
//                                                         BorderRadius
//                                                             .circular(
//                                                             30)),
//                                                     alignment:
//                                                     Alignment.center,
//                                                     width:
//                                                     screenWidth * .35,
//                                                     child: const Text(
//                                                         "Yes, Resume",
//                                                         style: TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold,
//                                                             color: AppColors
//                                                                 .whiteColor)),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 30,
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         child: Container(
//                           padding:
//                           const EdgeInsets.only(top: 10, bottom: 10),
//                           margin:
//                           const EdgeInsets.only(top: 10, bottom: 10),
//                           decoration: BoxDecoration(
//                               color:
//                               Theme.of(context).colorScheme.primary,
//                               borderRadius: BorderRadius.circular(30)),
//                           alignment: Alignment.center,
//                           width: screenWidth * .35,
//                           child: const Text("Resume",
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   color: AppColors.whiteColor)),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   )
//                 ],
//               );
//             }
//
//             Widget callInfoCard(BuildContext context) {
//               return GestureDetector(
//                 onTap: () {
//                   showContactDetails(context);
//                 },
//                 child: Container(
//                   margin: const EdgeInsets.only(
//                     bottom: 8,
//                     left: 2,
//                   ),
//                   width: MediaQuery.of(context).size.width,
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.surface,
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                           width: 1,
//                           color: Theme.of(context).colorScheme.outline)),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Image.asset(
//                             AppImages.frIcon,
//                             height: 40,
//                             width: 40,
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             "Phoenix",
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: BoxDecoration(
//                               color:
//                               Theme.of(context).colorScheme.surfaceBright,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: const Text(
//                               "Online",
//                               style: TextStyle(
//                                 color: AppColors.whiteColor,
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           CircleAvatar(
//                             radius: 22, // Size of the circle
//                             backgroundColor: Theme.of(context)
//                                 .colorScheme
//                                 .primary, // Circle background color
//                             child: const Icon(
//                               Icons.call, // Icon you want inside the circle
//                               color: Colors.white, // Icon color
//                               size: 24, // Icon size
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             }
//
//             Widget franchisesTabView() {
//               return Container(
//                 width: screenWidth,
//                 height: 400,
//                 padding: const EdgeInsets.only(
//                     left: 10, right: 10, top: 10, bottom: 10),
//                 child: ListView.builder(
//                   itemCount: 20,
//                   itemBuilder: (context, index) {
//                     return callInfoCard(context);
//                   },
//                 ),
//               );
//             }
//
//             return Wrap(
//               children: [
//                 Container(
//                   width: screenWidth,
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Pause/Start Auction",
//                             style: TextStyle(
//                                 color: Theme.of(context).colorScheme.primary,
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Container(
//                             alignment: Alignment.centerRight,
//                             child: InkWell(
//                               onTap: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Icon(
//                                 Icons.close,
//                                 size: 30,
//                                 color: Theme.of(context).colorScheme.surfaceDim,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.only(
//                                 left: 10, right: 20, top: 5, bottom: 5),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .secondaryFixed,
//                                     width: 1)),
//                             width: screenWidth * .425,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 RichText(
//                                     textAlign: TextAlign.left,
//                                     text: TextSpan(
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                           fontFamily: 'Lufga',
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .surfaceBright,
//                                         ),
//                                         children: [
//                                           const TextSpan(
//                                             text: "Online",
//                                           ),
//                                           TextSpan(
//                                               text: "\nFranchise",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.normal,
//                                                   fontSize: 16,
//                                                   color: Theme.of(context)
//                                                       .colorScheme
//                                                       .surfaceDim)),
//                                         ])),
//                                 Text(
//                                   "10",
//                                   style: TextStyle(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .surfaceDim,
//                                       fontSize: 36,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: const EdgeInsets.only(
//                                 left: 10, right: 20, top: 5, bottom: 5),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(15),
//                                 border: Border.all(
//                                     color: Theme.of(context)
//                                         .colorScheme
//                                         .secondaryFixed,
//                                     width: 1)),
//                             width: screenWidth * .425,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 RichText(
//                                     textAlign: TextAlign.left,
//                                     text: TextSpan(
//                                         style: TextStyle(
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w500,
//                                           fontFamily: 'Lufga',
//                                           color: isDarkMode ? DarkColors.notificationOrange : LightColors.notificationOrange,
//                                         ),
//                                         children: [
//                                           const TextSpan(
//                                             text: "Offline",
//                                           ),
//                                           TextSpan(
//                                               text: "\nFranchise",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.normal,
//                                                   fontSize: 16,
//                                                   color: Theme.of(context)
//                                                       .colorScheme
//                                                       .surfaceDim)),
//                                         ])),
//                                 Text(
//                                   "4",
//                                   style: TextStyle(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .surfaceDim,
//                                       fontSize: 36,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       DefaultTabController(
//                         length: 2,
//                         child: Column(
//                           children: [
//                             TabBar(
//                               indicatorSize: TabBarIndicatorSize.tab,
//                               labelStyle:
//                               Theme.of(context).textTheme.titleMedium,
//                               labelColor: AppColors.whiteColor,
//                               unselectedLabelColor:
//                               Theme.of(context).colorScheme.surfaceDim,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 0.0,
//                                 vertical: 0.0,
//                               ),
//                               indicator: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(30.0),
//                                 color: isDarkMode
//                                     ? Theme.of(context).colorScheme.tertiary
//                                     : Theme.of(context).primaryColor,
//                               ),
//                               tabs: const [
//                                 Tab(height: 60, text: "Auction"),
//                                 Tab(height: 60, text: "Franchises"),
//                               ],
//                             ),
//                             SizedBox(
//                               height: screenHeight * .5,
//                               child: TabBarView(
//                                 children: [
//                                   auctionTabView(),
//                                   franchisesTabView(),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
//
//   showCloseConfirmation() {
//     bool isSwitched = true;
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(25.0), // Rounded top corners
//         ),
//       ),
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       builder: (context) {
//         return StatefulBuilder(
//           // Needed to manage state inside the bottom sheet
//           builder: (context, setModalState) {
//             return Wrap(
//               children: [
//                 Container(
//                   width: screenWidth,
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: Icon(Icons.close,
//                               size: 30,
//                               color: Theme.of(context).colorScheme.surfaceDim)),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset(
//                             AppImages.alertSign,
//                             width: 50,
//                             height: 50,
//                             colorFilter: ColorFilter.mode(
//                               isDarkMode ? DarkColors.notificationOrange : LightColors.notificationOrange,
//                               BlendMode.srcIn,
//                             ),
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           const Text(
//                             "Do you want to CLOSE betting on this Auction?",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.only(
//                                       top: 10, bottom: 10),
//                                   margin: const EdgeInsets.only(
//                                       top: 10, bottom: 10, left: 10, right: 10),
//                                   decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .primary),
//                                       color:
//                                       Theme.of(context).colorScheme.surface,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   alignment: Alignment.center,
//                                   width: screenWidth * .35,
//                                   child: Text(
//                                     "Cancel",
//                                     style:
//                                     Theme.of(context).textTheme.titleLarge,
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Container(
//                                   padding: const EdgeInsets.only(
//                                       top: 10, bottom: 10),
//                                   margin: const EdgeInsets.only(
//                                       top: 10, bottom: 10, left: 10, right: 10),
//                                   decoration: BoxDecoration(
//                                       color:
//                                       Theme.of(context).colorScheme.primary,
//                                       borderRadius: BorderRadius.circular(30)),
//                                   alignment: Alignment.center,
//                                   width: screenWidth * .35,
//                                   child: const Text("Yes, Close",
//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                           color: AppColors.whiteColor)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 30,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
//
// // Container(
// // height: 50,
// // width: 50,
// // color: Colors.transparent,
// // child: ClipPath(
// // child: Confetti(
// // controller: confettiController,
// // options: const ConfettiOptions(
// // particleCount: 100, spread: 70, y: 1),
// // ),
// // ),
// // ),
// class HalfCircleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     double radius = 100;
//
//     Path path = Path();
//     path
//       ..moveTo(size.width / 2, 0)
//       ..arcToPoint(Offset(size.width, size.height),
//           radius: Radius.circular(radius))
//       ..lineTo(0, size.height)
//       ..arcToPoint(
//         Offset(size.width / 2, 0),
//         radius: Radius.circular(radius),
//       )
//       ..close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }