import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_list_view/group_list_view.dart';

import '../../../utils/app_logger.dart';
import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class AllPlayersView extends StatefulWidget {
  final bool isLoading;

  const AllPlayersView({super.key, required this.isLoading});

  @override
  State<AllPlayersView> createState() => _AllPlayersViewState();
}

class _AllPlayersViewState extends State<AllPlayersView> {
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');

  final Map<String, List> _elements = {
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
              separatorBuilder: (context, index) => Dimensions.verticalSpace(1),
              sectionSeparatorBuilder: (context, section) =>
                  Dimensions.verticalSpace(1),
            ),
          )
        ],
      ),
    );
  }

  bool isBookMarkedPlayer = false;

  Widget playerCard(BuildContext context, IndexPath index) {
    isBookMarkedPlayer ??= (index.index / 2) == 0 ? true : false;
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
                      AppLogger.log("hhvbbbb: " + isBookMarkedPlayer.toString());
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
            width: Dimensions.screenWidth(context) * .2,
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
                  : const SizedBox(height: 30, width: 30),
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
                  width: Dimensions.screenWidth(context),
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
                            height: Dimensions.screenWidth(context) * .15,
                            width: Dimensions.screenWidth(context) * .15,
                          ),
                          Dimensions.horizontalSpace(
                              Dimensions.screenWidth(context) * .03),
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
                      Dimensions.verticalSpace(30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Dimensions.screenWidth(context) * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Player Bio:",
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Dimensions.verticalSpace(10),
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
                      Dimensions.verticalSpace(20),
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
                      Dimensions.verticalSpace(30),
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
