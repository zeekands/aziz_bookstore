part of 'get_list_love_theme_cubit.dart';

@freezed
class GetListLoveThemeState with _$GetListLoveThemeState {
  const factory GetListLoveThemeState.initial() = _Initial;
  const factory GetListLoveThemeState.loading() = _Loading;
  const factory GetListLoveThemeState.loaded(BookList books) = _Loaded;
  const factory GetListLoveThemeState.error(Failure failure) = _Error;
}
