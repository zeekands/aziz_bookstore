import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_book_state.dart';
part 'search_book_cubit.freezed.dart';

class SearchBookCubit extends Cubit<SearchBookState> {
  final GetListBookUsecae _getListBookUsecae;
  SearchBookCubit(this._getListBookUsecae) : super(const SearchBookState.initial());

  static List<Book> listBooks = <Book>[];
  static bool hasReachedMax = false;

  void searchBook(String query) async {
    emit(const SearchBookState.loading());

    final result = await _getListBookUsecae.execute(BookRequestModel(search: query));
    result.fold(
      (failure) => emit(SearchBookState.error(failure)),
      (books) {
        emit(SearchBookState.loaded(books));
        listBooks = books.books;
      },
    );
  }

  void loadMore(String query, page) async {
    emit(SearchBookState.loadMore(listBooks, true, false));
    final result = await _getListBookUsecae.execute(BookRequestModel(search: query, page: page));
    result.fold(
      (failure) => emit(SearchBookState.error(failure)),
      (data) {
        if (data.next == null || data.next == "") {
          listBooks.addAll(data.books);
          if (data.books.isEmpty) {
            hasReachedMax = true;
          }
          emit(SearchBookState.loadMore(listBooks, false, hasReachedMax));
          return;
        }
        listBooks.addAll(data.books);
        emit(SearchBookState.loadMore(listBooks, false, false));
      },
    );
  }

  void clear() {
    emit(const SearchBookState.initial());
  }
}
