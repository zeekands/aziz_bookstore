// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class StickyTabDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  StickyTabDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 45; // Atur tinggi maksimum header di sini

  @override
  double get minExtent => 45; // Atur tinggi minimum header di sini

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
