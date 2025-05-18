import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class TabView extends StatelessWidget {
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  TabView({super.key});

  double screenHeight = 0;
  double screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return ContainedTabBarView(
      // tab titles
      tabs: const [
        Text('Activities'),
        Text('Squads'),
        Text('All Players'),
      ],
      tabBarProperties: TabBarProperties(
        background: Container(
          decoration: BoxDecoration(
              color: purple30, borderRadius: BorderRadius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 0.0,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 20.0,
        ),
        indicator: ContainerTabIndicator(
          height: 40,
          width: 120,
          padding: const EdgeInsets.only(left: 5, right: 5),
          radius: BorderRadius.circular(30.0),
          color: primaryBlue,
          borderWidth: 0.0,

        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
      ),
      // tab views
      views: [
        activitiesView(),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text("Squads"),
          ),
        ),
        Container(
          color: Colors.white,
          child: const Center(
            child: Text("All Players"),
          ),
        ),
      ],
      onChange: (index) => debugPrint(index.toString()),
    );
  }

  // Activities list view. List of activities are combined together.
  Widget activitiesView() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          activityCard1(0, true, false),
          activityCard2(1, false, false),
          activityCard4(2, false, false),
          activityCard3(3, false, false),
          activityCard1(4, false, true),
        ],
      ),
    );
  }

  // created different view for activities with different content

  // Activity Type 1
  Widget activityCard1(int index, bool start, bool end) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          mileStoneLine(start, end),
          Container(
            width: screenWidth * .8,
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: purple40)),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "10:36",
                      style: TextStyle(color: darkGrey60, fontSize: 13),
                    ),
                    Image.asset(
                      AppImages.playerDefaultImage,
                      height: 45,
                      width: 45,
                    ),
                  ],
                ),
                SizedBox(
                    width: screenWidth * .5,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontFamily: 'Lufga'),
                        children: [
                          TextSpan(text: 'Mapple Premier League has '),
                          TextSpan(
                              text: 'resumed ',
                              style: TextStyle(
                                  color: primaryBlue,
                                  fontWeight: FontWeight.bold)),
                          TextSpan(text: 'the auction'),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "5000",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Activity Type 2
  Widget activityCard2(int index, bool start, bool end) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          mileStoneLine(start, end),
          Container(
            width: screenWidth * .8,
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: purple40)),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "10:36",
                      style: TextStyle(color: darkGrey60, fontSize: 13),
                    ),
                    Image.asset(
                      AppImages.playerDefaultImage,
                      height: 45,
                      width: 45,
                    ),
                  ],
                ),
                SizedBox(
                    width: screenWidth * .5,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontFamily: 'Lufga'),
                        children: [
                          TextSpan(text: 'Mapple Premier League has '),
                          TextSpan(
                              text: 'paused ',
                              style: TextStyle(
                                  color: orange, fontWeight: FontWeight.bold)),
                          TextSpan(text: 'the auction'),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "5000",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Activity Type 3
  Widget activityCard3(int index, bool start, bool end) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          mileStoneLine(start, end),
          Container(
            width: screenWidth * .8,
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: purple40)),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "10:36",
                      style: TextStyle(color: darkGrey60, fontSize: 13),
                    ),
                    Image.asset(
                      AppImages.playerImage,
                      height: 45,
                      width: 45,
                    ),
                  ],
                ),
                SizedBox(
                    width: screenWidth * .5,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontFamily: 'Lufga'),
                        children: [
                          TextSpan(text: 'Player "Wamsi Guru" '),
                          TextSpan(
                              text: 'Sold', style: TextStyle(color: green)),
                          TextSpan(
                            text: "\n",
                          ),
                          TextSpan(
                            text: 'Sold to: ',
                          ),
                          TextSpan(
                              text: 'Phoenix',
                              style: TextStyle(color: purple40)),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "2000",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Activity Type 4
  Widget activityCard4(int index, bool start, bool end) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          mileStoneLine(start, end),
          Container(
            width: screenWidth * .8,
            margin: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(width: 1, color: purple40)),
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "10:36",
                      style: TextStyle(color: darkGrey60, fontSize: 13),
                    ),
                    Image.asset(
                      AppImages.playerImage,
                      height: 45,
                      width: 45,
                    ),
                  ],
                ),
                SizedBox(
                    width: screenWidth * .5,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontFamily: 'Lufga'),
                        children: [
                          TextSpan(text: 'Player "Sourav Bhatt" '),
                          TextSpan(
                            text: "\n",
                          ),
                          TextSpan(
                              text: 'Unsold',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 50,
                  width: screenWidth * .1,
                  child: const Center(
                    child: Text(
                      "",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // left line in the design. for first activity, top line should be hidden,
  // and for last activity, bottom line should be hidden.
  // 'start' and 'end' boolean values indicates whether the activity if first or last
  Widget mileStoneLine(bool start, bool end) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5),
          width: 1,
          height: 50,
          color: start ? Colors.transparent : lightGrey,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: navyBlue,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 1,
          height: 50,
          margin: const EdgeInsets.only(left: 5),
          color: end ? Colors.transparent : lightGrey,
        ),
      ],
    );
  }
}
