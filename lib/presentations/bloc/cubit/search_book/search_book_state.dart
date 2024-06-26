part of 'search_book_cubit.dart';

@freezed
class SearchBookState with _$SearchBookState {
  const factory SearchBookState.initial() = _Initial;
  const factory SearchBookState.loading() = _Loading;
  const factory SearchBookState.loaded(BookList books) = _Loaded;
  const factory SearchBookState.loadMore(List<Book> moreBooks, bool showLoading, bool hasReachedMax) = _LoadMore;
  const factory SearchBookState.error(Failure message) = _Error;
}
