import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/images.dart';

class CloseConfirmSheet extends StatefulWidget {
  const CloseConfirmSheet({super.key});

  @override
  State<CloseConfirmSheet> createState() => _CloseConfirmSheetState();
}

class _CloseConfirmSheetState extends State<CloseConfirmSheet> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          width: Dimensions.screenWidth(context),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context, result);
                  },
                  child: Icon(Icons.close,
                      size: 30,
                      color: Theme.of(context).colorScheme.surfaceDim)),
              Dimensions.verticalSpace(10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppImages.alertSign,
                    width: 50,
                    height: 50,
                    colorFilter: ColorFilter.mode(
                      AppState.isDarkMode(context)
                          ? DarkColors.notificationOrange
                          : LightColors.notificationOrange,
                      BlendMode.srcIn,
                    ),
                  ),
                  Dimensions.verticalSpace(10),
                  const Text(
                    "Do you want to CLOSE betting on this Auction?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Dimensions.verticalSpace(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, result);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).colorScheme.primary),
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          width: Dimensions.screenWidth(context) * .35,
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context, result);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(30)),
                          alignment: Alignment.center,
                          width: Dimensions.screenWidth(context) * .35,
                          child: const Text("Yes, Close",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor)),
                        ),
                      ),
                    ],
                  ),
                  Dimensions.verticalSpace(30),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
