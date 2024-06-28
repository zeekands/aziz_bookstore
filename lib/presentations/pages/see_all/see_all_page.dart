import 'package:aziz_bookstore/core/extentions/theme_extention.dart';
import 'package:aziz_bookstore/core/extentions/widget_extentions.dart';
import 'package:aziz_bookstore/core/theme/colors.dart';
import 'package:aziz_bookstore/data/models/see_all_arguments.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/see_all_book/see_all_cubit_cubit.dart';
import 'package:aziz_bookstore/presentations/components/wave_loading.dart';
import 'package:aziz_bookstore/presentations/pages/explore_page/explore_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SeeAllPage extends StatefulWidget {
  const SeeAllPage({super.key});

  @override
  State<SeeAllPage> createState() => _SeeAllPageState();
}

class _SeeAllPageState extends State<SeeAllPage> {
  late SeeAllArguments argumentsData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    argumentsData = ModalRoute.of(context)?.settings.arguments as SeeAllArguments;
    BlocProvider.of<SeeAllCubitCubit>(context).getSeeAllBooks(argumentsData.topic!);

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
          setState(() {
            _hasReachBottom = true;
          });

          if (!_isPageLoading) {
            _page++;
            BlocProvider.of<SeeAllCubitCubit>(context).loadMore(argumentsData.topic!, _page);
          }
          _isPageLoading = true;
        } else {
          _hasReachBottom = false;
        }
      },
    );
  }

  var _hasReachBottom = false;
  var _isPageLoading = false;
  var _page = 1;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SeeAllPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'List ${argumentsData.title}',
          style: context.headline6TextStyle?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: BlocListener<SeeAllCubitCubit, SeeAllCubitState>(
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
          child: BlocBuilder<SeeAllCubitCubit, SeeAllCubitState>(
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
                      for (var book in SeeAllCubitCubit.listBooks) ItemBookExplore(book: book),
                      if (showLoading)
                        for (int i = 0; i < 4; i++) const ShimmerItemBookExplore()
                    ],
                  );
                },
                loaded: (listBook) {
                  if (listBook.books.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/img_empty_item.png',
                          height: 300,
                        ),
                        Text(
                          'No result found!',
                          style: context.titleLargeTextStyle,
                        ),
                        8.heightBox,
                        const Text("Let's find another book!"),
                      ],
                    ).toCenter();
                  }
                  return StaggeredGrid.count(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                    children: [
                      for (var book in SeeAllCubitCubit.listBooks) ItemBookExplore(book: book),
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
      ).paddingSymmetric(horizontal: 16),
    );
  }
}
