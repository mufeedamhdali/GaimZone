import 'package:flutter/material.dart';
import 'package:gaimzone/utils/colors.dart';

import 'circular_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? leadingIcon;
  final String? trailingIcon;

  const CustomAppBar({
    required this.title,
     this.leadingIcon,
     this.trailingIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30)),
      child: AppBar(
        centerTitle: false,
        titleSpacing: 10, // removes spacing before title
        backgroundColor: whiteColor,
        surfaceTintColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leadingIcon != null ?  CircularIcon(
              size: MediaQuery.of(context).size.width * .1,
              icon: leadingIcon!,
              padding: 15,
            ) : Container(),
            Text(title),
            // for notification icon with dot
            trailingIcon != null ? Stack(
              children: [
                CircularIcon(size: MediaQuery.of(context).size.width * .1, icon: trailingIcon!, padding: 12,),
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: orange,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                  ),
                ),
              ],
            ) : Container()
          ],
        ),
      ),
    );
  }
}
