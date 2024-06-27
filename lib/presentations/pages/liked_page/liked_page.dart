import 'package:aziz_bookstore/core/extentions/navigator_extentions.dart';
import 'package:aziz_bookstore/core/extentions/scaffold_extentions.dart';
import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/routes/app_paths.dart';
import 'package:aziz_bookstore/data/datasources/local_data_source/db_helper.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Books',
          style: context.headline6TextStyle?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: getLikedBooksStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: context.bodyMediumTextStyle,
              ),
            );
          }

          if (snapshot.hasData) {
            final books = snapshot.data as List<Book>;

            if (books.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/img_empty_item.png',
                    height: 300,
                  ),
                  Text(
                    'No liked books',
                    style: context.titleLargeTextStyle,
                  ),
                  8.heightBox,
                  const Text("Let's find and save your favorite books!"),
                ],
              ).toCenter();
            } else {
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(books[index].id.toString()),
                    onDismissed: (direction) {
                      databaseHelper.deleteBook(books[index].id);
                      context.showSnackBar(
                        SnackBar(
                          content: const Text('Book removed from liked list'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              databaseHelper.createBook(books[index]);
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(AppPaths.bookDetail, arguments: books[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 8, left: 16, right: 16),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 0,
                              blurRadius: 7,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                imageUrl: books[index].formats.imageJpeg,
                                height: 130,
                                width: 80,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const CircularProgressIndicator(),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            8.widthBox,
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          books[index].title,
                                          style: context.titleMediumTextStyle
                                              ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      8.widthBox,
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
                                            books[index].downloadCount.toString(),
                                            style: context.bodySmallTextStyle?.copyWith(
                                                fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 10),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Builder(
                                    builder: (context) {
                                      var authors = "";
                                      for (var author in books[index].authors) {
                                        authors += author.name ?? "" ", ";
                                      }
                                      return Text(
                                        "By :$authors",
                                        style: context.bodySmallTextStyle?.copyWith(
                                            fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 12),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                      );
                                    },
                                  ),
                                  4.heightBox,
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Text(
                                      books[index].languages.join(", "),
                                      style: context.bodySmallTextStyle?.copyWith(
                                          fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 12),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  4.heightBox,
                                  Text(
                                    books[index].bookshelves.join(", "),
                                    style: context.bodySmallTextStyle
                                        ?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 12),
                                    textAlign: TextAlign.start,
                                  ),
                                  4.heightBox,
                                  Text(
                                    "Media Type : ${books[index].mediaType}",
                                    style: context.bodySmallTextStyle
                                        ?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 11),
                                    textAlign: TextAlign.start,
                                  ),
                                  4.heightBox,
                                  Text(
                                    "Subjects :",
                                    style: context.bodySmallTextStyle
                                        ?.copyWith(fontWeight: FontWeight.w600, color: Colors.grey[500], fontSize: 12),
                                  ),
                                  4.heightBox,
                                  Builder(builder: (context) {
                                    var subjects = books[index].subjects;
                                    if (books[index].subjects.length > 2) {
                                      subjects = books[index].subjects.sublist(0, 2);
                                    }
                                    return Wrap(
                                      spacing: 4,
                                      runSpacing: 4,
                                      children: subjects
                                          .map(
                                            (e) => Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                e,
                                                style: context.bodySmallTextStyle?.copyWith(
                                                    fontWeight: FontWeight.w400, color: Colors.grey[500], fontSize: 10),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }
}
