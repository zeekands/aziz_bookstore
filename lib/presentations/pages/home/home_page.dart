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
import 'package:redacted/redacted.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
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
                height: 250,
                decoration: const BoxDecoration(color: Color(0xffF6A6B5)),
                padding: const EdgeInsets.only(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enjoy Your Love Theme Books',
                      style: context.titleMediumTextStyle?.copyWith(fontWeight: FontWeight.w600, color: cMainWhite),
                    ).paddingSymmetric(horizontal: 16),
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
                                      borderRadius: BorderRadius.circular(8),
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
                                            topLeft: Radius.circular(8),
                                            topRight: Radius.circular(8),
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
                                        4.heightBox,
                                        Text(
                                          "${book.title}\n",
                                          style: context.bodySmallTextStyle
                                              ?.copyWith(fontWeight: FontWeight.w600, color: cMainBlack),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        ).paddingSymmetric(horizontal: 8, vertical: 4),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child:
                    Text('Popular Books', style: context.titleMediumTextStyle?.copyWith(fontWeight: FontWeight.w600)),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Fresh Books For You!',
                    style: context.titleMediumTextStyle?.copyWith(fontWeight: FontWeight.w600)),
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text('English Book', style: context.titleMediumTextStyle?.copyWith(fontWeight: FontWeight.w600)),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See All'),
                    ),
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
            ],
          ),
        ),
      ),
    );
  }
}
