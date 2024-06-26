import 'package:aziz_bookstore/core/extentions/navigator_extentions.dart';
import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/routes/app_paths.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/core/theme/status_bar_color.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_eng_book/get_list_eng_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_love_theme/get_list_love_theme_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_new_release/get_list_new_release_cubit.dart';
import 'package:aziz_bookstore/presentations/components/item_book.dart';
import 'package:aziz_bookstore/presentations/components/item_book_with_card.dart';
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
                                    ItemBookWithCard(
                                      book: book,
                                      onTap: () {
                                        context.pushNamed(AppPaths.bookDetail, arguments: book);
                                      },
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
                            for (var book in books.books)
                              ItemBook(
                                  book: book,
                                  onTap: () {
                                    context.pushNamed(AppPaths.bookDetail, arguments: book);
                                  }),
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
                            for (var book in books.books)
                              ItemBook(
                                  book: book,
                                  onTap: () {
                                    context.pushNamed(AppPaths.bookDetail, arguments: book);
                                  }),
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
                            for (var book in books.books)
                              ItemBook(
                                book: book,
                                onTap: () {
                                  context.pushNamed(AppPaths.bookDetail, arguments: book);
                                },
                              ),
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
