import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListBookHomePlaceholder extends StatelessWidget {
  const ListBookHomePlaceholder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < 5; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    width: 100,
                    height: 150,
                  ),
                ),
                4.heightBox,
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    width: 100,
                    height: 20,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
