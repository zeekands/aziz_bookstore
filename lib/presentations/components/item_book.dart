import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:flutter/material.dart';

class ItemBook extends StatelessWidget {
  const ItemBook({
    super.key,
    this.book,
    this.textColor,
  });

  final Book? book;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              book?.formats.imageJpeg ?? '',
              height: 150,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 150,
                  width: 100,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          ),
          4.heightBox,
          Text(
            book?.title ?? 'Placeholder',
            style: context.bodySmallTextStyle?.copyWith(fontWeight: FontWeight.w600, color: textColor ?? cMainBlack),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
