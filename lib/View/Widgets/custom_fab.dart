import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../utils/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressedClose;
  final VoidCallback onPressedSettings;

  const CustomFloatingActionButton(
      {super.key,
      required this.onPressedClose,
      required this.onPressedSettings});

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      overlayOpacity: 0,
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      direction: SpeedDialDirection.left,
      tooltip: 'Options',
      childrenButtonSize: const Size(56.0, 56.0),
      buttonSize: const Size(50.0, 50.0),
      shape: const CircleBorder(),
      icon: Icons.more_horiz,
      activeIcon: Icons.more_horiz,
      activeBackgroundColor: Theme.of(context).colorScheme.secondaryFixed,
      backgroundColor: Theme.of(context).primaryColor,
      children: [
        SpeedDialChild(
          backgroundColor: Theme.of(context).colorScheme.error,
          shape: const CircleBorder(),
          child: const Icon(Icons.close, color: AppColors.whiteColor),
          onTap: onPressedClose,
        ),
        SpeedDialChild(
          backgroundColor: Theme.of(context).primaryColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.settings,
            color: AppColors.whiteColor,
          ),
          onTap: onPressedSettings,
        ),
      ],
    );
  }
}
