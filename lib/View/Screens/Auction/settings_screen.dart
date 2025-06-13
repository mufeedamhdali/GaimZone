// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_confetti/flutter_confetti.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
// import 'package:gaimzone/utils/images.dart';
//
// import 'package:gaimzone/utils/colors.dart';
//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({
//     super.key,
//   });
//
//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }
//
// class _SettingsScreenState extends State<SettingsScreen> {
//   final confettiController = ConfettiController();
//   double screenWidth = 0;
//   double screenHeight = 0;
//   double titleHeight = 0;
//   double backgroundHeight = 0;
//   double appBarHeight = 0;
//   double largeCircleWidth = 0;
//   double curveWith = 0;
//   double gapWidth = 0;
//   double tabViewHeight = 0;
//   double collapsedCircleWidth = 0;
//   double topPadding = 0;
//   double imageViewHeight = 0;
//   double bidButtonViewHeight = 0;
//   double playersSummaryHeight = 0;
//   double balanceViewHeight = 0;
//   double roundCornerHeight = 0;
//
//   bool isBidEnabled = true;
//
//   final CountDownController _controller = CountDownController();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   setDimension(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;
//     titleHeight = screenHeight * .5;
//     appBarHeight = screenHeight * .07;
//     largeCircleWidth = screenWidth * .22;
//     curveWith = largeCircleWidth * .6;
//     gapWidth = largeCircleWidth * .07;
//     tabViewHeight = screenHeight * .6;
//     collapsedCircleWidth = screenWidth * .17;
//     topPadding = screenHeight * .1;
//     imageViewHeight = screenHeight * .585;
//     playersSummaryHeight = appBarHeight + screenHeight * .08;
//     bidButtonViewHeight = screenHeight * .15;
//     balanceViewHeight = screenHeight * .15;
//     roundCornerHeight = screenHeight * .07;
//     backgroundHeight = screenHeight * .75;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     setDimension(context);
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(appBarHeight),
//         child: auctionTopBar(),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(child: collapseLayout()),
//             Container(
//                 padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
//                 height: tabViewHeight,
//                 child: const TabView()),
//           ],
//         ),
//       ),
//       floatingActionButton: SpeedDial(
//         overlayOpacity: 0,
//         iconTheme: const IconThemeData(color: AppColors.whiteColor),
//         direction: SpeedDialDirection.left,
//         tooltip: 'Options',
//         childrenButtonSize: const Size(56.0, 56.0),
//         buttonSize: const Size(50.0, 50.0),
//         shape: const CircleBorder(),
//         icon: Icons.more_horiz,
//         activeIcon: Icons.more_horiz,
//         activeBackgroundColor: Theme.of(context).colorScheme.secondaryFixed,
//         backgroundColor: Theme.of(context).primaryColor,
//         children: [
//           SpeedDialChild(
//             backgroundColor: Theme.of(context).primaryColor,
//             shape: const CircleBorder(),
//             child: const Icon(
//               Icons.settings,
//               color: AppColors.whiteColor,
//             ),
//             onTap: () => print('Call tapped'),
//           ),
//           SpeedDialChild(
//             backgroundColor: Theme.of(context).colorScheme.error,
//             shape: const CircleBorder(),
//             child: const Icon(Icons.close, color: AppColors.whiteColor),
//             onTap: () => print('Message tapped'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget collapseLayout() {
//     return Container(
//       height: 200,
//       alignment: Alignment.topCenter,
//       child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints constraints) {
//         final double currentHeight = constraints.biggest.height;
//         final double collapseProgress =
//             (currentHeight - kToolbarHeight) / (titleHeight - kToolbarHeight);
//         final bool isExpanded = collapseProgress >= 0.8;
//         return Stack(
//           children: [
//             Positioned(
//               top: appBarHeight ,
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: AnimatedOpacity(
//                 opacity: isExpanded ? 0.0 : 1.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: collapsedWidget(),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
//
//
//   Widget collapsedWidget() {
//     return Container(
//       width: screenWidth,
//       color: Theme.of(context).colorScheme.surfaceTint,
//       alignment: Alignment.center,
//       padding: EdgeInsets.only(top: 40),
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
//                           TextStyle(color: AppColors.whiteColor, fontSize: 9),
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
//         ],
//       ),
//     );
//   }
//
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
//                 const EdgeInsets.only(top: 2, left: 12, right: 12, bottom: 2),
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
// }
