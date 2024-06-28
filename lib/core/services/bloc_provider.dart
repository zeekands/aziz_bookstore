import 'package:aziz_bookstore/core/injection/di.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_book/get_list_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_eng_book/get_list_eng_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_love_theme/get_list_love_theme_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_new_release/get_list_new_release_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/search_book/search_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/see_all_book/see_all_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static get getproviders => [
        BlocProvider(create: (_) => locator<GetListBookCubit>()),
        BlocProvider(create: (_) => locator<GetListEngBookCubit>()),
        BlocProvider(create: (_) => locator<GetListNewReleaseCubit>()),
        BlocProvider(create: (_) => locator<GetListLoveThemeCubit>()),
        BlocProvider(create: (_) => locator<SearchBookCubit>()),
        BlocProvider(create: (_) => locator<SeeAllCubitCubit>()),
      ];
}
