import 'package:aziz_bookstore/core/error/failure.dart';
import 'package:aziz_bookstore/data/models/book_model.dart';
import 'package:aziz_bookstore/data/models/book_request_model.dart';
import 'package:aziz_bookstore/domain/usecases/get_list_book_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_list_love_theme_state.dart';
part 'get_list_love_theme_cubit.freezed.dart';

class GetListLoveThemeCubit extends Cubit<GetListLoveThemeState> {
  final GetListBookUsecae _getListBookUsecae;
  GetListLoveThemeCubit(this._getListBookUsecae) : super(const GetListLoveThemeState.initial());

  void getLoveThemeBooks() async {
    emit(const GetListLoveThemeState.loading());
    final result = await _getListBookUsecae.execute(BookRequestModel(topic: "love"));
    result.fold(
      (failure) => emit(GetListLoveThemeState.error(failure)),
      (books) => emit(GetListLoveThemeState.loaded(books)),
    );
  }
}
