import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class SquadsView extends StatefulWidget {
  final bool isLoading;

  const SquadsView({super.key, required this.isLoading});

  @override
  State<SquadsView> createState() => _SquadsViewState();
}

class _SquadsViewState extends State<SquadsView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
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
                Dimensions.verticalSpace(8),
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
                        Dimensions.verticalSpace(5),
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
}
