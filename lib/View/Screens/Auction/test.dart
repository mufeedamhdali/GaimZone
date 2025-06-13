// import 'package:flutter/material.dart';
// import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
//
// double screenWidth = 0;
// double screenHeight = 0;
//
// @override
// Widget build(BuildContext context) {
//   screenHeight = MediaQuery.of(context).size.height;
//   screenWidth = MediaQuery.of(context).size.width;
//   double titleHeight = screenHeight * .3;
//   double backgroundHeight = screenHeight * .7;
//   return Scaffold(
//     body: CustomScrollView(
//       physics: const BouncingScrollPhysics(),
//       slivers: [
//         SliverAppBar(
//           expandedHeight: backgroundHeight,
//           flexibleSpace: FlexibleSpaceBar(
//             stretchModes: const [
//               StretchMode.zoomBackground,
//               StretchMode.blurBackground,
//               StretchMode.fadeTitle
//
//             ],
//             titlePadding: EdgeInsets.zero,
//             title: Align(
//               alignment: Alignment.topCenter,
//               child: LayoutBuilder(
//                   builder: (BuildContext context, BoxConstraints constraints) {
//                     final double currentHeight = constraints.biggest.height;
//                     final double collapseProgress =
//                         (currentHeight - kToolbarHeight) /
//                             (titleHeight - kToolbarHeight);
//                     final bool isExpanded = collapseProgress >= 0.6;
//                     return AnimatedOpacity(
//                       opacity: isExpanded ? 0.0 : 1.0,
//                       duration: Duration(milliseconds: 300),
//                       child: Container(
//                         color: Colors.blueAccent,
//                         height: titleHeight,
//                         alignment: Alignment.center,
//                         child: const Text(
//                           'Title Widget (300px)',
//                           style: TextStyle(fontSize: 28, color: Colors.white),
//                         ),
//                       ),
//                     );
//                   }
//               ),
//             ),
//             background: LayoutBuilder(
//               builder: (BuildContext context, BoxConstraints constraints) {
//                 final double currentHeight = constraints.biggest.height;
//                 final double collapseProgress =
//                     (currentHeight - kToolbarHeight) / (titleHeight - kToolbarHeight);
//                 final bool isCollapsed = collapseProgress <= 0.2;
//
//                 return Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     // Background widget (700 height)
//                     Positioned(
//                       top: 0,
//                       left: 0,
//                       right: 0,
//                       height: backgroundHeight,
//                       child: AnimatedOpacity(
//                         opacity: isCollapsed ? 0.0 : 1.0,
//                         duration: const Duration(milliseconds: 300),
//                         child: Container(height: 700,),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ),
//         // Sliver to hold the main content, using a SingleChildScrollView
//         SliverToBoxAdapter(
//             child: Container(
//                 padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
//                 height: 700,
//                 child: const TabView())
//         ),
//       ],
//     ),
//   );
// }