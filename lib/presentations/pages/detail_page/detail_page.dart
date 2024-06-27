// ignore_for_file: library_private_types_in_public_api

import 'package:aziz_bookstore/core/extentions/mediaquery_extentions.dart';
import 'package:aziz_bookstore/core/extentions/navigator_extentions.dart';
import 'package:aziz_bookstore/core/extentions/scaffold_extentions.dart';
import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/data/datasources/local_data_source/db_helper.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/presentations/pages/web_view/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shimmer/shimmer.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SingleTickerProviderStateMixin {
  late Book? book;
  final gemini = Gemini.instance;
  var summary = "";
  var authorSummary = "";
  var _loadSummary = true;
  var _loadAuthorSummary = true;
  var genreOfBook = "";
  var _loadGenre = true;
  var languages = "";
  var _loadLanguages = true;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    book = ModalRoute.of(context)?.settings.arguments as Book?;
    getSummaryBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          LoveIconWidget(
            book: book,
          ),
        ],
        title: Text('Book Info', style: context.titleLargeTextStyle?.copyWith(fontWeight: FontWeight.w700)),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  16.heightBox,
                  Container(
                    height: 250,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(book?.formats.imageJpeg ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ).toCenter(),
                  16.heightBox,
                  Text(
                    book?.title ?? '',
                    style: context.headline5TextStyle?.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 16),
                  8.heightBox,
                  Builder(
                    builder: (context) {
                      var authors = "";
                      for (var author in book?.authors ?? []) {
                        authors += author.name ?? "" ", ";
                      }
                      return Text(
                        "By : $authors",
                        style:
                            context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w400, color: Colors.grey[500]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      );
                    },
                  ),
                  8.heightBox,
                  Divider(
                    color: context.primaryColor.withOpacity(.2),
                    thickness: 1,
                  ),
                  8.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.primaryColor.withOpacity(.2)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Language',
                              style: context.bodyMediumTextStyle
                                  ?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xff858585)),
                            ),
                            4.heightBox,
                            Text(
                              book?.languages.join(", ") ?? '',
                              style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.primaryColor.withOpacity(.2)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Downloads',
                              style: context.bodyMediumTextStyle
                                  ?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xff858585)),
                            ),
                            4.heightBox,
                            Text(
                              book?.downloadCount.toString() ?? '',
                              style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: context.primaryColor.withOpacity(.2)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Copyright',
                              style: context.bodyMediumTextStyle
                                  ?.copyWith(fontWeight: FontWeight.w400, color: const Color(0xff858585)),
                            ),
                            4.heightBox,
                            Text(
                              book?.copyright.toString() ?? '',
                              style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  8.heightBox,
                ],
              ),
            ),
            SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                  pinned: true,
                  delegate: StickyTabDelegate(
                    child: Container(
                      height: 90,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          border: Border(
                            bottom: BorderSide(width: 1.5, color: Color(0xFFEFEFEF)),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TabBar(
                          controller: _tabController,
                          tabAlignment: TabAlignment.start,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: const [
                            Tab(text: 'Overview'),
                            Tab(text: 'Authors'),
                            Tab(text: 'Languages'),
                            Tab(text: 'Genre'),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            overviewSection(context),
            authorSummarySection(context),
            languageOfBookSection(context),
            genreOfBookSection(context),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            context.push(
              MaterialPageRoute(
                  builder: (context) => CustomWebView(
                        url: book?.formats.textHtml ?? '',
                        title: book?.title,
                      )),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Read Now',
                  style: context.bodyMediumTextStyle?.copyWith(fontWeight: FontWeight.w500, color: cMainWhite),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: cMainWhite,
                ),
              ],
            ),
          ).paddingSymmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }

  Widget overviewSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.screenHeight * .07),
          if (_loadSummary)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
              ],
            )
          else
            Markdown(
              data: summary,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
            ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }

  Widget authorSummarySection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.screenHeight * .07),
          if (_loadAuthorSummary)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
              ],
            )
          else
            Markdown(
              data: authorSummary,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
            ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }

  Widget genreOfBookSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.screenHeight * .07),
          if (_loadGenre)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
              ],
            )
          else
            Markdown(
              data: genreOfBook,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
            ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }

  Widget languageOfBookSection(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: context.screenHeight * .07),
          if (_loadLanguages)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
                const SizedBox(height: 10),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    height: 20.0,
                  ),
                ),
              ],
            )
          else
            Markdown(
              data: languages,
              shrinkWrap: true,
              padding: const EdgeInsets.all(0),
              physics: const NeverScrollableScrollPhysics(),
            ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }

  void getSummaryBook() {
    gemini.text("search summary of this book ${book?.title} by $book").then((value) {
      setState(
        () {
          summary = value?.content?.parts?.last.text ?? "";
          _loadSummary = false;
          if (summary.isEmpty) {
            summary = "Summary not found";
          }
        },
      );
    }).catchError(
      (e) {
        setState(
          () {
            _loadSummary = false;
            summary = "Summary not found";
          },
        );
      },
    );

    gemini.text("search biography of ${book?.authors[0].name} ${book?.title}").then((value) {
      setState(
        () {
          authorSummary = value?.content?.parts?.last.text ?? "No author summary found";
          _loadAuthorSummary = false;
        },
      );
    }).catchError(
      (e) {
        setState(
          () {
            authorSummary = "Author summary not found";
            _loadAuthorSummary = false;
          },
        );
      },
    );

    gemini.text("search genre of ${book?.title} and tell me litle bit about the genre in book genre").then((value) {
      setState(
        () {
          genreOfBook = value?.content?.parts?.last.text ?? "No genre found";
          _loadGenre = false;
        },
      );
    }).catchError(
      (e) {
        setState(
          () {
            genreOfBook = "Genre not found";
            _loadGenre = false;
          },
        );
      },
    );

    gemini.text("search languages of book ${book?.title} and tell me the release date").then((value) {
      setState(
        () {
          languages = value?.content?.parts?.last.text ?? "No languages found";
          _loadLanguages = false;
        },
      );
    }).catchError(
      (e) {
        setState(
          () {
            languages = "Languages not found";
            _loadLanguages = false;
          },
        );
      },
    );
  }
}

class LoveIconWidget extends StatefulWidget {
  final Book? book;

  const LoveIconWidget({Key? key, required this.book}) : super(key: key);

  @override
  _LoveIconWidgetState createState() => _LoveIconWidgetState();
}

class _LoveIconWidgetState extends State<LoveIconWidget> {
  bool _isLiked = false;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: databaseHelper.isBookLiked(widget.book!.id),
      builder: (context, snapshot) {
        _isLiked = snapshot.data ?? false;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Icon(Icons.favorite_border);
        } else {
          _isLiked = snapshot.data ?? false;
          return IconButton(
            icon: Icon(
              _isLiked ? Icons.favorite : Icons.favorite_border,
              color: _isLiked ? Colors.red : null,
            ),
            onPressed: _toggleLikedStatus,
          );
        }
      },
    );
  }

  void _toggleLikedStatus() {
    if (_isLiked) {
      databaseHelper.deleteBook(widget.book!.id);
      context.showSnackBar(
        const SnackBar(
          content: Text('Book removed from liked list'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      databaseHelper.createBook(widget.book!);
      context.showSnackBar(
        const SnackBar(
          content: Text('Book added to liked list'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    }
    setState(() {
      _isLiked = !_isLiked;
    });
  }
}

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
