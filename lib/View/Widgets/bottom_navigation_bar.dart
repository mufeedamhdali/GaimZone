import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/images.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.pageIndex});

  final int pageIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      height: 97,
      top: -30,
      backgroundColor: primaryBlue,
      style: TabStyle.fixedCircle,
      curveSize: 110,
      curve: Curves.easeInOutBack,
      items: [
        TabItem(icon: iconWidget(AppImages.homeIcon), title: "Home"),
        TabItem(icon: iconWidget(AppImages.playersIcon), title: "Players"),
        TabItem(icon: auctionIcon(), title: "Auction"),
        TabItem(icon: iconWidget(AppImages.clubIcon), title: "Club"),
        TabItem(icon: iconWidget(AppImages.userIcon), title: "Players"),
      ],
      initialActiveIndex: 2,
      onTap: (int i) => debugPrint('click index=$i'),
    );
  }

  // normal icons
  Widget iconWidget(String image) {
    return SizedBox(
        height: 45,
        width: 45,
        child: Image.asset(
          image,
          height: 40,
          width: 40,
        ));
  }

  // center auction icon
  Widget auctionIcon() {
    final CountDownController controller = CountDownController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          children: [
            CircularCountDownTimer(
              duration: 60,
              initialDuration: 0,
              controller: controller,
              width: MediaQuery.of(context).size.width * .17,
              height: MediaQuery.of(context).size.width * .17,
              ringColor: darkGrey60,
              fillColor: purple40,
              backgroundColor: primaryBlue,
              strokeWidth: 10,
              strokeCap: StrokeCap.square,
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.S,
              isTimerTextShown: true,
              isReverseAnimation: true,
              isReverse: true,
              autoStart: true,
            ),
            Positioned(
              top: 45,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * .17,
                height: 20,
                color: Colors.transparent,
                child: const Text(
                  "Sec",
                  style: TextStyle(fontSize: 11, color: whiteColor),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Auction",
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
