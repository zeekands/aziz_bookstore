part of 'get_list_eng_book_cubit.dart';

@freezed
class GetListEngBookState with _$GetListEngBookState {
  const factory GetListEngBookState.initial() = _Initial;
  const factory GetListEngBookState.loading() = _Loading;
  const factory GetListEngBookState.loaded(BookList books) = _Loaded;
  const factory GetListEngBookState.error(Failure failure) = _Error;
}
