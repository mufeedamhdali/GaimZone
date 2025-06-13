import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class TabView extends StatefulWidget {
  final bool isLoading;

  const TabView({super.key, required this.isLoading});

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  double screenHeight = 0;
  double screenWidth = 0;
  int selectedIndex = 0;
  bool isDarkMode = true;

  Map<String, List> _elements = {
    'Bookmarked(6)': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
    'Others(194)': [
      'Toyah Downs',
      'Tyla Kane',
      'Tyla Kane',
    ],
  };

  final List<String> _options = [
    'All',
    'Remaining',
    'Sold',
    'Unsold',
  ];

  String? _selectedOption = 'All';

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TabBarView(
      children: [
        activitiesView(),
        squadsView(),
        allPlayersView(),
      ],
    );
  }

  Widget _buildShimmerEndorsement(
      {double? height, double? width, double? radius}) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceDim.withOpacity(.2),
      highlightColor: Theme.of(context).colorScheme.surfaceDim.withOpacity(.4),
      child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(radius ?? 5)),
          margin: const EdgeInsets.all(1),
          height: height,
          width: width),
    );
  }

  Widget squadsView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceTint,
          borderRadius: BorderRadius.circular(40)),
      child: Row(
        children: [
          Container(
            width: 100,
            margin: const EdgeInsets.only(top: 15, left: 5, bottom: 20),
            child: Column(
              children: [
                Text(
                  "Franchises",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 5,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: franchisesIcon(
                                selectedIndex == index ? true : false, true),
                          )),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(40)),
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 8,
                      bottom: 8,
                    ),
                    width: MediaQuery.of(context).size.width * .65,
                    padding: const EdgeInsets.only(top: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Spent ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  TextSpan(
                                      text: '5555',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Balance ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  TextSpan(
                                      text: '5555',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Players ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium),
                                  TextSpan(
                                      text: '8/10',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 6,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(
                          bottom: 8,
                          left: 8,
                        ),
                        width: MediaQuery.of(context).size.width * .6,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              blurRadius: .5,
                              offset: const Offset(-1, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              AppImages.playerImage,
                              height: 35,
                              width: 35,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .3,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rishabh Dash",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  Text("Bowler",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall)
                                ],
                              ),
                            ),
                            Text(
                              "2800",
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget activitiesView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(40)),
      padding: const EdgeInsets.only(bottom: 0),
      margin: const EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          activityCard1(0, true, false),
          activityCard2(1, false, false),
          activityCard4(2, false, false),
          activityCard3(3, false, false),
          activityCard1(4, false, false),
          activityCard3(3, false, false),
          activityCard1(4, false, true)
        ],
      ),
    );
  }

  Widget allPlayersView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(40)),
      padding: const EdgeInsets.only(bottom: 0),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _options.map((option) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: Theme.of(context).colorScheme.primaryFixed,
                    value: option,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value;
                      });
                    },
                  ),
                  Text(
                    option,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              );
            }).toList(),
          ),
          Divider(
            color: Theme.of(context).colorScheme.surfaceTint,
          ),
          Container(
            margin: const EdgeInsets.only(
              bottom: 8,
            ),
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 12),
            child: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge,
                children: [
                  TextSpan(
                      text: 'Total Players ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primaryFixed,
                      )),
                  TextSpan(
                    text: '  200',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.surfaceDim,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GroupListView(
              padding: EdgeInsets.zero,
              sectionsCount: _elements.keys.toList().length,
              countOfItemInSection: (int section) {
                return _elements.values.toList()[section].length;
              },
              itemBuilder: playerCard,
              groupHeaderBuilder: (BuildContext context, int section) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                  child: Text(
                    _elements.keys.toList()[section],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 1),
              sectionSeparatorBuilder: (context, section) =>
                  const SizedBox(height: 1),
            ),
          )
        ],
      ),
    );
  }

  bool isBookMarkedPlayer = false;

  Widget playerCard(BuildContext context, IndexPath index) {
    if (isBookMarkedPlayer == null) {
      isBookMarkedPlayer = (index.index / 2) == 0 ? true : false;
    }
    bool isSold = (index.index / 2) == 0 ? true : false;
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
        left: 2,
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            offset: const Offset(0, 4),
            blurRadius: .1,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() async {
                isBookMarkedPlayer =
                    await showPlayerDetails(isBookMarkedPlayer ?? false);
              });
            },
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImages.playerImage,
                  height: 40,
                  width: 40,
                ),
                isBookMarkedPlayer
                    ? Positioned(
                        right: -5,
                        child: SvgPicture.asset(
                          AppImages.bookmarkBadge,
                          width: 20,
                          height: 20,
                        ))
                    : Container()
              ],
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() async {
                      isBookMarkedPlayer =
                          await showPlayerDetails(isBookMarkedPlayer ?? false);
                      print("hhvbbbb: " + isBookMarkedPlayer.toString());
                    });
                  },
                  child: Text(
                    "Rishabh Dash",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(
                  "Bowler",
                  style: Theme.of(context).textTheme.displayMedium,
                )
              ],
            ),
          ),
          SizedBox(
            width: screenWidth * .2,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSold ? "Sold" : "UnSold",
                  style: TextStyle(
                      color: isSold
                          ? Theme.of(context).colorScheme.surfaceBright
                          : Theme.of(context).colorScheme.error,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  isSold ? "Your Game" : "",
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Theme.of(context).colorScheme.surfaceDim,
                    fontSize: 13,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: SizedBox(
              height: 30,
              width: 30,
              child: isSold
                  ? Image.asset(
                      AppImages.frIcon,
                      fit: BoxFit.fitWidth,
                    )
                  : Container(height: 30, width: 30),
            ),
          ),
          Text(
            "2800",
            style: TextStyle(
                color: Theme.of(context).colorScheme.surfaceDim,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  // created different view for activities with different content
  Widget activityCard1(int index, bool start, bool end) {
    return Container(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            color: Theme.of(context).colorScheme.surface,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                mileStoneLine(start, end),
                widget.isLoading
                    ? _buildShimmerEndorsement(width: screenWidth * .8, height: 60, radius: 20)
                    : Container(
                  width: screenWidth * .8,
                  margin: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                  ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: Theme.of(context).colorScheme.surfaceTint)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Opacity(
                            opacity: .5,
                            child: Text(
                              "10:36",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
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
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                const TextSpan(
                                    text: 'Mapple Premier League has '),
                                TextSpan(
                                    text: 'resumed ',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary,
                                        fontWeight: FontWeight.bold)),
                                const TextSpan(text: 'the auction'),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 50,
                        child: Center(
                          child: Text(
                            "5000",
                            style: Theme.of(context).textTheme.titleLarge,
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
      color: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.surfaceTint)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: .5,
                      child: Text(
                        "10:36",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
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
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const [
                          TextSpan(text: 'Mapple Premier League has '),
                          TextSpan(
                              text: 'paused ',
                              style: TextStyle(
                                  color: AppColors.orange,
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

  // Activity Type 3
  Widget activityCard3(int index, bool start, bool end) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      color: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.surfaceTint)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: .5,
                      child: Text("10:36",
                          style: Theme.of(context).textTheme.bodySmall),
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
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const [
                          TextSpan(text: 'Player "Wamsi Guru" '),
                          TextSpan(
                              text: 'Sold',
                              style: TextStyle(color: AppColors.green)),
                          TextSpan(
                            text: "\n",
                          ),
                          TextSpan(
                            text: 'Sold to: ',
                          ),
                          TextSpan(
                              text: 'Phoenix',
                              style: TextStyle(color: AppColors.lightP)),
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
      color: Theme.of(context).colorScheme.surface,
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
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    width: 1,
                    color: Theme.of(context).colorScheme.surfaceTint)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: .5,
                      child: Text(
                        "10:36",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
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
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          const TextSpan(text: 'Player "Sourav Bhatt" '),
                          const TextSpan(
                            text: "\n",
                          ),
                          TextSpan(
                              text: 'Unsold',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error)),
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
  Widget mileStoneLine(bool start, bool end) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 5),
          width: 1,
          height: 40,
          color: start
              ? Colors.transparent
              : Theme.of(context).colorScheme.surfaceTint,
        ),
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.darkBlue,
            shape: BoxShape.circle,
          ),
        ),
        Container(
          width: 1,
          height: 40,
          margin: const EdgeInsets.only(left: 5),
          color: end
              ? Colors.transparent
              : Theme.of(context).colorScheme.surfaceTint,
        ),
      ],
    );
  }

  franchisesIcon(bool isSelected, bool isOnline) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 4, left: 5),
                  height: 70,
                  constraints: const BoxConstraints(minWidth: 70),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1)
                        : null,
                  ),
                  child: Image.asset(
                    AppImages.frIcon,
                  ),
                ),
                isOnline
                    ? Positioned(
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
                      )
                    : Container(),
              ],
            ),
            isSelected
                ? Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: SvgPicture.asset(
                      AppImages.rightArrow,
                      width: 8,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : const SizedBox(
                    width: 10,
                    height: 8,
                  )
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 8, left: 5),
          width: 80,
          child: Text(
            "Sports Club",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        )
      ],
    );
  }

  Future<bool> showPlayerDetails(bool isBookMarked) async {
    bool isSwitched = isBookMarked;
    bool result = isBookMarked;
    final res = await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            AppImages.playerImage,
                            height: screenWidth * .15,
                            width: screenWidth * .15,
                          ),
                          SizedBox(
                            width: screenWidth * .03,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shivram Raj",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surfaceDim,
                                    fontSize: 20),
                              ),
                              Text(
                                "Wicket Keeper",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Player Bio:",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                    "elementum ultrices ipsum risus sapien sit quis elit eget facilisis amet, urna. orci Donec Lorem placerat massa varius Ut ex "),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "Bookmark",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Switch(
                                trackOutlineColor:
                                    WidgetStateProperty.resolveWith<Color?>(
                                  (states) {
                                    if (states.contains(WidgetState.selected)) {
                                      return null;
                                    }
                                    return AppColors.darkGrey.withOpacity(.5);
                                  },
                                ),
                                inactiveThumbColor:
                                    AppColors.darkGrey.withOpacity(.5),
                                value: isSwitched,
                                onChanged: (value) {
                                  setModalState(() {
                                    isSwitched = value;
                                    isBookMarked = value;
                                    result = value;
                                  });
                                  setState(() {
                                    isSwitched = value;
                                    isBookMarked = value;
                                    result = value;
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Endorsements: ",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          infoCard("Wicketkeeper", "25"),
                          infoCard("Bowler", "12"),
                          infoCard("All-rounder", "13"),
                          infoCard("Finisher", "2"),
                          infoCard("Finisher", "2"),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Primary Role: ",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "Striker",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: .5,
                            color: Theme.of(context).colorScheme.surfaceDim,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Secondary Role: ",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "Bowler",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: .5,
                            color: Theme.of(context).colorScheme.surfaceDim,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Preferred Food: ",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                "Biriyani",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          Divider(
                            thickness: .5,
                            color: Theme.of(context).colorScheme.surfaceDim,
                          ),
                        ],
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
    if (res != null) {
      setState(() {
        isBookMarked = result;
      });
    }
    return result;
  }

  Widget infoCard(String label, String count) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 12, right: 5),
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
          top: 4,
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
}
