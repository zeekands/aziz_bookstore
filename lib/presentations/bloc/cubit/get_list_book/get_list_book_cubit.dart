import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_list_book_state.dart';
part 'get_list_book_cubit.freezed.dart';

class GetListBookCubit extends Cubit<GetListBookState> {
  final GetListBookUsecae _getListBookUsecae;
  GetListBookCubit(this._getListBookUsecae) : super(const GetListBookState.initial());

  Future<void> getBooks() async {
    emit(const GetListBookState.loading());
    final result = await _getListBookUsecae.execute(BookRequestModel());
    result.fold(
      (failure) => emit(GetListBookState.error(failure)),
      (books) => emit(GetListBookState.loaded(books)),
    );
  }
}
