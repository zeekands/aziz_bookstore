part of 'get_list_book_cubit.dart';

@freezed
class GetListBookState with _$GetListBookState {
  const factory GetListBookState.initial() = _Initial;
  const factory GetListBookState.loading() = _Loading;
  const factory GetListBookState.loaded(BookList books) = _Loaded;
  const factory GetListBookState.error(Failure message) = _Error;
}
