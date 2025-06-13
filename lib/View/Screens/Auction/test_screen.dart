// import 'package:auto_scroll_slider/auto_scroll_slider.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/material.dart';
// import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
// import 'package:gaimzone/utils/colors.dart';
// import 'package:gaimzone/utils/images.dart';
//
// import '../../Widgets/custom_painter.dart';
//
// class AuctionScreen2 extends StatefulWidget {
//   const AuctionScreen2({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<AuctionScreen2> createState() => _AuctionScreen2State();
// }
//
// class _AuctionScreen2State extends State<AuctionScreen2> {
//   List A = [
//     'https://picsum.photos/id/1018/600/300',
//     'https://picsum.photos/id/1015/600/300',
//     'https://picsum.photos/id/1019/600/300',
//   ];
//
//   ScrollController scrollControllerA = ScrollController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: SingleChildScrollView(
//           child: Container(
//             height: 500,
//             width: MediaQuery.of(context).size.width,
//             child: AutoScrollSlider(
//               duration: 10,
//               scrollDirection:Axis.horizontal,
//               length: A.length,
//               scrollController: scrollControllerA,
//               itemBuilder: (context, index) {
//                 return Image.network(
//                   A[index],
//                   height: 250,
//                   width: MediaQuery.of(context).size.width,
//                   fit: BoxFit.cover,
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
