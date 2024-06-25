import 'package:aziz_bookstore/core/services/network_service.dart';
import 'package:aziz_bookstore/data/datasources/remote_data_source/books_remote_data_source.dart';
import 'package:aziz_bookstore/data/repositories/books_repository_impl.dart';
import 'package:aziz_bookstore/domain/repositories/books_repository.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_eng_book/get_list_eng_book_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_love_theme/get_list_love_theme_cubit.dart';
import 'package:aziz_bookstore/presentations/bloc/cubit/get_list_new_release/get_list_new_release_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // cubit or bloc
  locator.registerFactory(() => GetListBookCubit(locator()));
  locator.registerFactory(() => GetListEngBookCubit(locator()));
  locator.registerFactory(() => GetListNewReleaseCubit(locator()));
  locator.registerFactory(() => GetListLoveThemeCubit(locator()));

  // usecase
  locator.registerLazySingleton(() => GetListBookUsecae(locator()));

  // repository
  locator.registerLazySingleton<BooksRepository>(() => BooksRepositoryImpl(locator()));

  // data sources
  locator.registerLazySingleton<BooksRemoteDataSource>(() => BooksRemoteDataSourceImpl());

  locator.registerSingleton<HttpService>(HttpService());
}
