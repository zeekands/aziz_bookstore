part of 'see_all_cubit_cubit.dart';

@freezed
class SeeAllCubitState with _$SeeAllCubitState {
  const factory SeeAllCubitState.initial() = _Initial;
  const factory SeeAllCubitState.loading() = _Loading;
  const factory SeeAllCubitState.loaded(BookList books) = _Loaded;
  const factory SeeAllCubitState.loadMore(List<Book> moreBooks, bool showLoading, bool hasReachedMax) = _LoadMore;
  const factory SeeAllCubitState.error(Failure failure) = _Error;
}
