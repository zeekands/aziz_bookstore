import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemBookWithCard extends StatelessWidget {
  const ItemBookWithCard({
    super.key,
    required this.book,
    this.onTap,
  });

  final Book book;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: cMainWhite,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1599999964237213),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        width: 100,
        margin: const EdgeInsets.only(right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              child: CachedNetworkImage(
                imageUrl: book.formats.imageJpeg,
                height: 150,
                width: 100,
                fit: BoxFit.cover,
                errorWidget: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    width: 100,
                    color: Colors.grey[300],
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                4.heightBox,
                Builder(
                  builder: (context) {
                    var languages = "";
                    for (var language in book.languages) {
                      languages += language;
                    }
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Text(
                        languages,
                        style: context.bodySmallTextStyle
                            ?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 10),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    );
                  },
                ),
                4.heightBox,
                Text(
                  "${book.title}\n",
                  style: context.bodySmallTextStyle?.copyWith(fontWeight: FontWeight.w600, color: cMainBlack),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                4.heightBox,
                Builder(
                  builder: (context) {
                    var authors = "";
                    for (var author in book.authors) {
                      authors += author.name ?? "" ", ";
                    }
                    return Text(
                      authors,
                      style: context.bodySmallTextStyle
                          ?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    );
                  },
                ),
                4.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.download,
                      color: Colors.grey[500],
                      size: 13,
                    ),
                    4.widthBox,
                    Text(
                      book.downloadCount.toString(),
                      style: context.bodySmallTextStyle
                          ?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                4.heightBox,
              ],
            ).paddingSymmetric(horizontal: 4),
          ],
        ),
      ),
    );
  }
}
