import 'dart:async';

import 'package:aziz_bookstore/core/extentions/mediaquery_extentions.dart';
import 'package:aziz_bookstore/core/extentions/navigator_extentions.dart';
import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/routes/app_paths.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/search_book/search_book_cubit.dart';
import 'package:aziz_bookstore/presentations/components/wave_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  var _hasReachBottom = false;
  var _isPageLoading = false;
  var _page = 1;
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          setState(() {
            _hasReachBottom = true;
          });
          if (!_isPageLoading) {
            _page++;
            context.read<SearchBookCubit>().loadMore(
                  _searchController.text,
                  _page,
                );
          }
          _isPageLoading = true;
        } else {
          _hasReachBottom = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Explore',
          style: context.headline6TextStyle?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              controller: _searchController,
              onSubmitted: (value) {
                _page = 1;
                if (value.isEmpty) {
                  context.read<SearchBookCubit>().clear();
                  return;
                }
                context.read<SearchBookCubit>().searchBook(value);
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: context.bodyText1TextStyle?.copyWith(
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          4.heightBox,
          Flexible(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: BlocListener<SearchBookCubit, SearchBookState>(
                listener: (context, state) {
                  state.maybeWhen(
                    loadMore: (listBook, showLoading, hasReachedMax) {
                      setState(() {
                        _isPageLoading = false;
                      });
                    },
                    loading: () {
                      setState(() {
                        _isPageLoading = true;
                      });
                    },
                    error: (message) => setState(() {
                      _isPageLoading = false;
                    }),
                    orElse: () {
                      setState(() {
                        _isPageLoading = false;
                      });
                    },
                  );
                },
                child: BlocBuilder<SearchBookCubit, SearchBookState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const InitialStateExplore().paddingOnly(top: 100),
                      loading: () => Center(child: const WaveDots(size: 70, color: cMainPurple).paddingOnly(top: 200)),
                      loadMore: (listBook, showLoading, hasReachedMax) {
                        return StaggeredGrid.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 8,
                          children: [
                            for (var book in SearchBookCubit.listBooks) ItemBookExplore(book: book),
                            if (showLoading)
                              for (int i = 0; i < 4; i++) const ShimmerItemBookExplore()
                          ],
                        );
                      },
                      loaded: (listBook) {
                        return StaggeredGrid.count(
                          crossAxisCount: 4,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 8,
                          children: [
                            for (var book in SearchBookCubit.listBooks) ItemBookExplore(book: book),
                            if (_hasReachBottom)
                              for (int i = 0; i < 4; i++) const ShimmerItemBookExplore()
                          ],
                        );
                      },
                      error: (failure) => Center(
                        child: Text(failure.message),
                      ),
                    );
                  },
                ),
              ).toCenter(),
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 16),
    );
  }
}

class ShimmerItemBookExplore extends StatelessWidget {
  const ShimmerItemBookExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 250,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              height: 14,
              width: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 4),
            Container(
              height: 16,
              width: 100,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 4),
            Container(
              height: 14,
              width: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  height: 13,
                  width: 13,
                  color: Colors.grey[300],
                ),
                const SizedBox(width: 4),
                Container(
                  height: 13,
                  width: 20,
                  color: Colors.grey[300],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ItemBookExplore extends StatelessWidget {
  const ItemBookExplore({
    super.key,
    required this.book,
  });

  final Book book;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(AppPaths.bookDetail, arguments: book);
      },
      child: SizedBox(
        width: 100,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
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
            Builder(
              builder: (context) {
                var languages = "";
                for (var language in book.languages) {
                  languages += "$language, ";
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
              book.title,
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
                  maxLines: 2,
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
          ],
        ),
      ),
    );
  }
}

class InitialStateExplore extends StatelessWidget {
  const InitialStateExplore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/img_search.png',
          width: context.screenWidth * 0.7,
          height: context.screenHeight * 0.3,
          fit: BoxFit.fill,
        ),
        16.heightBox,
        Text(
          'Discover new books and authors',
          style: context.headline6TextStyle?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        8.heightBox,
        Text(
          'Fill in the search box to find your favourite books and authors',
          style: context.bodyText1TextStyle?.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

Future<LottieComposition?> customDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(bytes, filePicker: (files) {
    return files.firstWhere((f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
  });
}
