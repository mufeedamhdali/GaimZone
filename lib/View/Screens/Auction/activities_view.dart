import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class ActivitiesView extends StatefulWidget {
  final bool isLoading;

  const ActivitiesView({super.key, required this.isLoading});

  @override
  State<ActivitiesView> createState() => _ActivitiesViewState();
}

class _ActivitiesViewState extends State<ActivitiesView> {
  @override
  Widget build(BuildContext context) {
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
              ? CustomShimmer.shimmerDefault(context,
                  width: Dimensions.screenWidth(context) * .8, height: 60, radius: 20)
              : Container(
                  width: Dimensions.screenWidth(context) * .8,
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
                          width: Dimensions.screenWidth(context) * .5,
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
            width: Dimensions.screenWidth(context) * .8,
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
                    width: Dimensions.screenWidth(context) * .5,
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
            width: Dimensions.screenWidth(context) * .8,
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
                    width: Dimensions.screenWidth(context) * .5,
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
            width: Dimensions.screenWidth(context) * .8,
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
                    width: Dimensions.screenWidth(context) * .5,
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
                  width: Dimensions.screenWidth(context) * .1,
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
}
