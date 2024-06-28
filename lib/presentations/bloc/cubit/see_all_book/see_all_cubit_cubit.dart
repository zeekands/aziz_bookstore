import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'see_all_cubit_state.dart';
part 'see_all_cubit_cubit.freezed.dart';

class SeeAllCubitCubit extends Cubit<SeeAllCubitState> {
  final GetListBookUsecae _getListBookUsecae;
  SeeAllCubitCubit(this._getListBookUsecae) : super(const SeeAllCubitState.initial());

  static List<Book> listBooks = <Book>[];
  static bool hasReachedMax = false;

  void getSeeAllBooks(BookRequestModel bookRequest) async {
    emit(const SeeAllCubitState.loading());
    final result = await _getListBookUsecae.execute(bookRequest);
    result.fold(
      (failure) => emit(SeeAllCubitState.error(failure)),
      (books) {
        listBooks = books.books;
        emit(SeeAllCubitState.loaded(books));
      },
    );
  }

  void loadMore(BookRequestModel bookRequest, page) async {
    emit(SeeAllCubitState.loadMore(listBooks, true, false));
    final result = await _getListBookUsecae.execute(bookRequest.copyWith(page: page));
    result.fold(
      (failure) => emit(SeeAllCubitState.error(failure)),
      (data) {
        if (data.next == null || data.next == "") {
          listBooks.addAll(data.books);
          if (data.books.isEmpty) {
            hasReachedMax = true;
          }
          emit(SeeAllCubitState.loadMore(listBooks, false, hasReachedMax));
          return;
        }
        listBooks.addAll(data.books);
        emit(SeeAllCubitState.loadMore(listBooks, false, false));
      },
    );
  }
}
