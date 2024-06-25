import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_list_eng_book_state.dart';
part 'get_list_eng_book_cubit.freezed.dart';

class GetListEngBookCubit extends Cubit<GetListEngBookState> {
  final GetListBookUsecae _getListBookUsecae;
  GetListEngBookCubit(this._getListBookUsecae) : super(const GetListEngBookState.initial());

  Future<void> getEngBooks() async {
    emit(const GetListEngBookState.loading());
    final result = await _getListBookUsecae.execute(BookRequestModel(languange: 'eng'));
    result.fold(
      (failure) => emit(GetListEngBookState.error(failure)),
      (books) => emit(GetListEngBookState.loaded(books)),
    );
  }
}
