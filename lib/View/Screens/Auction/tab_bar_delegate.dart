// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
//   final TabBar tabBar;
//
//   _SliverTabBarDelegate(this.tabBar);
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Theme.of(context).colorScheme.surface,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surfaceTint,
//             borderRadius: BorderRadius.circular(30)),
//         padding: const EdgeInsets.all(5),
//         margin: const EdgeInsets.all(5),
//         child: tabBar,
//       ),
//     );
//   }
//
//   @override
//   double get maxExtent => tabBar.preferredSize.height;
//
//   @override
//   double get minExtent => tabBar.preferredSize.height;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
//
