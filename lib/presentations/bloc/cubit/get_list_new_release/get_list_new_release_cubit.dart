import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_list_new_release_state.dart';
part 'get_list_new_release_cubit.freezed.dart';

class GetListNewReleaseCubit extends Cubit<GetListNewReleaseState> {
  final GetListBookUsecae _getListBookUsecae;
  GetListNewReleaseCubit(this._getListBookUsecae) : super(const GetListNewReleaseState.initial());

  Future<void> getNewReleaseBook() async {
    emit(const GetListNewReleaseState.loading());
    final result = await _getListBookUsecae.execute(BookRequestModel(sort: 'descending'));
    result.fold(
      (failure) => emit(GetListNewReleaseState.error(failure)),
      (books) => emit(GetListNewReleaseState.loaded(books)),
    );
  }
}
