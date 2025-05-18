import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:gaimzone/View/Screens/Auction/tab_view.dart';
import 'package:gaimzone/View/Widgets/custom_app_bar.dart';
import 'package:gaimzone/utils/colors.dart';
import 'package:gaimzone/utils/images.dart';

import '../../Widgets/bottom_navigation_bar.dart';
import '../../Widgets/custom_painter.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key, required this.title});

  final String title;

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  double screenWidth = 0;
  double screenHeight = 0;

  // controller for Timer widget
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    debugPrint("screenWidth: "+screenWidth.toString());
    debugPrint("screenHeight: "+screenHeight.toString());

    return Scaffold(
      backgroundColor: whiteColor,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * .075),
        child: CustomAppBar(
          title: widget.title,
          leadingIcon: AppImages.navBackIcon,
          trailingIcon: AppImages.notificationIcon,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // players summary
            Stack(
              children: [
                // rounded container for players summary background
                Container(
                  decoration: const BoxDecoration(
                      color: primaryBlue,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  height: 270,
                ),

                // rounded container for top section background
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                      color: navyBlue,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                ),

                // top section data
                Positioned(top: 100, child: topSection()),

                // players summary data
                Positioned(
                  top: 190,
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
                  child: timeTicker(),
                ),
                Positioned(
                  top: 220,
                  child: pointDetailsView(),
                ),
              ],
            ),

            // bid button and current status of balance and players
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(width: 1, color: primaryBlue),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  height: 270,
                ),
                Container(
                  height: 220,
                  decoration: const BoxDecoration(
                      color: purple30,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                ),
                Container(
                  height: 110,
                  decoration: const BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
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
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        decoration: BoxDecoration(
                            color: primaryBlue,
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        width: screenWidth * .8,
                        child: const Text(
                          "Bid - 2000",
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: whiteColor),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                              fontSize: 16,
                              color: primaryBlue,
                              fontFamily: 'Lufga'),
                          children: [
                            TextSpan(text: 'Max bid point: '),
                            TextSpan(
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
                  top: 230,
                  child: currentBalanceSummary(),
                ),
              ],
            ),

            // tab view for Activities, squads and All players list
            Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                height: 700,
                child: TabView())
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(
        pageIndex: 2,
      ),
    );
  }

  Widget topSection() {
    return SizedBox(
      width: screenWidth,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.playerDefaultImage,
                  height: screenWidth * .12,
                  width: screenWidth * .12,
                ),
                Positioned(
                  right: 02,
                  top: 02,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: green,
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
                  color: whiteColor, fontSize: 18, fontWeight: FontWeight.w800),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 2, left: 12, right: 12, bottom: 2),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: green, width: 1.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Live',
                style: TextStyle(
                    color: green, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget playersSummary() {
    return Stack(
      children: [
        curvedContainer(),
        Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          width: screenWidth,
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

  Widget curvedContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width * .35,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
              )),
        ),
        Container(
          color: Colors.transparent,
          child: Center(
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width * .3, 80),
              painter: CurvedPainter(),
            ),
          ),
        ),
        Container(
          height: 80,
          width: MediaQuery.of(context).size.width * .35,
          decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(70),
              )),
        ),
      ],
    );
  }

  Widget timeTicker() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            color: whiteColor,
            shape: BoxShape.circle,
          ),
          width: screenWidth * .22,
          height: screenWidth * .22,
        ),
        Container(
          decoration: BoxDecoration(
            color: whiteColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: primaryBlue,
              width: 1,
            ),
          ),
          width: screenWidth * .19,
          height: screenWidth * .19,
        ),
        Stack(
          children: [
            CircularCountDownTimer(
              duration: 60,
              initialDuration: 0,
              controller: _controller,
              width: screenWidth * .15,
              height: screenWidth * .15,
              ringColor: darkGrey60,
              fillColor: primaryBlue,
              backgroundColor: whiteColor,
              strokeWidth: 5,
              strokeCap: StrokeCap.square,
              textStyle: const TextStyle(
                fontSize: 20,
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.S,
              isTimerTextShown: true,
              isReverseAnimation: true,
              isReverse: true,
              autoStart: true,
            ),
            Positioned(
              top: 36,
              child: Container(
                alignment: Alignment.bottomCenter,
                width: screenWidth * .15,
                height: 20,
                color: Colors.transparent,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Sec",
                      style: TextStyle(fontSize: 12),
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
            // Largest circle
            Container(
              width: screenWidth * .9,
              height: screenWidth * .9,
              decoration: BoxDecoration(
                color: purple10,
                shape: BoxShape.circle,
                border: Border.all(
                  color: lightPurple,
                  width: 2,
                ),
              ),
            ),
            // Medium circle inside the largest one
            Container(
              width: screenWidth * .82,
              height: screenWidth * .82,
              decoration: BoxDecoration(
                color: lightGrey,
                shape: BoxShape.circle,
                border: Border.all(
                  color: purple70,
                  width: 2,
                ),
              ),
            ),
            // Smallest circle inside the medium one
            Container(
              width: screenWidth * .74,
              height: screenWidth * .74,
              decoration: BoxDecoration(
                color: primaryBlue,
                shape: BoxShape.circle,
                border: Border.all(
                  color: purple40,
                  width: 24,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset(AppImages.playerImage),
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
              width: screenWidth * .35,
              height: screenWidth * .35,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: lightYellow,
                  width: 2,
                ),
              ),
            ),
            // Largest circle
            Container(
              width: screenWidth * .3,
              height: screenWidth * .3,
              decoration: const BoxDecoration(
                color: blackColor,
                shape: BoxShape.circle,
              ),
            ),
            // Medium circle inside the largest one
            Container(
              width: screenWidth * .25,
              height: screenWidth * .25,
              decoration: BoxDecoration(
                color: blackColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: lightYellow,
                  width: 1,
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
                      style: TextStyle(color: whiteColor),
                    ),
                    Text(
                      "2000",
                      style: TextStyle(
                          color: lightPurple,
                          fontSize: 24,
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "Gurup Wamsi Kumar(Guru)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        RichText(
          text: const TextSpan(
            style: TextStyle(
                fontSize: 18, color: primaryBlue, fontFamily: 'Lufga'),
            children: [
              TextSpan(text: '32y old, '),
              TextSpan(
                text: 'Striker',
                style: TextStyle(
                    color: primaryBlue,
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
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 16, color: blackColor, fontFamily: 'Lufga'),
              children: [
                TextSpan(text: 'My balance: '),
                TextSpan(
                  text: '1800',
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                  fontSize: 16, color: blackColor, fontFamily: 'Lufga'),
              children: [
                TextSpan(text: 'My players: '),
                TextSpan(
                  text: '5/10',
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.bold),
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
              color: whiteColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: const TextStyle(color: whiteColor, fontSize: 15),
        ),
      ],
    );
  }

  Widget infoCard(String label, String count) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10, right: 5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [gradient1, gradient2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            margin: const EdgeInsets.only(
              left: 2,
            ),
            padding:
                const EdgeInsets.only(top: 3, bottom: 3, left: 8, right: 8),
            child: Text(
              label,
              style: const TextStyle(color: whiteColor, fontSize: 13),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: const EdgeInsets.all(0),
            decoration: const BoxDecoration(
              color: purple30,
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            child: Text(
              count,
              style: const TextStyle(
                color: primaryBlue,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
