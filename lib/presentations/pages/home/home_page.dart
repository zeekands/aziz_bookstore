import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/core/theme/status_bar_color.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_eng_book/get_list_eng_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_love_theme/get_list_love_theme_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_new_release/get_list_new_release_cubit.dart';
import 'package:aziz_bookstore/presentations/components/item_book.dart';
import 'package:aziz_bookstore/presentations/components/list_book_home_placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.goToExplorePage});

  final Function()? goToExplorePage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final listBanner = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/7.jpg",
    "assets/images/8.jpg",
    "assets/images/9.webp",
  ];
  @override
  void initState() {
    super.initState();
    context.read<GetListBookCubit>().getBooks();
    context.read<GetListNewReleaseCubit>().getNewReleaseBook();
    context.read<GetListEngBookCubit>().getEngBooks();
    context.read<GetListLoveThemeCubit>().getLoveThemeBooks();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    darkStatusBar();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text('Bookstore', style: context.titleLargeTextStyle?.copyWith(fontWeight: FontWeight.w700)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: widget.goToExplorePage,
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<GetListBookCubit>().getBooks();
            context.read<GetListNewReleaseCubit>().getNewReleaseBook();
            context.read<GetListEngBookCubit>().getEngBooks();
            context.read<GetListLoveThemeCubit>().getLoveThemeBooks();
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration: const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                  ),
                  items: listBanner.map((i) {
                    return Image.asset(
                      i,
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xffF6A6B5)),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Text('Enjoy Sweets Romance',
                                style: context.titleMediumTextStyle
                                    ?.copyWith(fontWeight: FontWeight.w600, color: cMainWhite)),
                            const Spacer(),
                            Text('See All', style: context.bodySmallTextStyle?.copyWith(color: cMainWhite)),
                          ],
                        ),
                      ),
                      8.heightBox,
                      BlocBuilder<GetListLoveThemeCubit, GetListLoveThemeState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () {
                              return const ListBookHomePlaceholder();
                            },
                            loaded: (books) => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var book in books.books)
                                    Container(
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
                                            child: Image.network(
                                              book.formats.imageJpeg,
                                              height: 150,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
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
                                                      style: context.bodySmallTextStyle?.copyWith(
                                                          fontWeight: FontWeight.w400,
                                                          color: Colors.grey[500],
                                                          fontSize: 10),
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
                                                style: context.bodySmallTextStyle
                                                    ?.copyWith(fontWeight: FontWeight.w600, color: cMainBlack),
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
                                                    style: context.bodySmallTextStyle?.copyWith(
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.grey[500],
                                                        fontSize: 10),
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
                                                    style: context.bodySmallTextStyle?.copyWith(
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.grey[500],
                                                        fontSize: 10),
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
                                ],
                              ).paddingSymmetric(horizontal: 8),
                            ),
                            error: (message) => Text(message.message),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                12.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text('Popular Book', style: context.titleMediumTextStyle?.copyWith(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text('See All', style: context.bodySmallTextStyle?.copyWith(color: cMainPurple)),
                    ],
                  ),
                ),
                8.heightBox,
                BlocBuilder<GetListBookCubit, GetListBookState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const ListBookHomePlaceholder();
                      },
                      loaded: (books) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var book in books.books) ItemBook(book: book),
                          ],
                        ),
                      ),
                      error: (message) => Text(message.message),
                    );
                  },
                ),
                12.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text('Fresh Book For You!',
                          style: context.titleMediumTextStyle?.copyWith(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text('See All', style: context.bodySmallTextStyle?.copyWith(color: cMainPurple)),
                    ],
                  ),
                ),
                8.heightBox,
                BlocBuilder<GetListNewReleaseCubit, GetListNewReleaseState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const ListBookHomePlaceholder();
                      },
                      loaded: (books) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var book in books.books) ItemBook(book: book),
                          ],
                        ),
                      ),
                      error: (message) => Text(message.message),
                    );
                  },
                ),
                12.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text('English Book', style: context.titleMediumTextStyle?.copyWith(fontWeight: FontWeight.w600)),
                      const Spacer(),
                      Text('See All', style: context.bodySmallTextStyle?.copyWith(color: cMainPurple)),
                    ],
                  ),
                ),
                8.heightBox,
                BlocBuilder<GetListEngBookCubit, GetListEngBookState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () {
                        return const ListBookHomePlaceholder();
                      },
                      loaded: (books) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (var book in books.books) ItemBook(book: book),
                          ],
                        ),
                      ),
                      error: (message) => Text(message.message),
                    );
                  },
                ),
                12.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
