import 'package:flutter/material.dart';

class CustomPinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  CustomPinnedHeaderDelegate({required this.widget, required this.height});

  Widget widget;
  double height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: widget);
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
