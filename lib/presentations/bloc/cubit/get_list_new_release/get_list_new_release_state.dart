part of 'get_list_new_release_cubit.dart';

@freezed
class GetListNewReleaseState with _$GetListNewReleaseState {
  const factory GetListNewReleaseState.initial() = _Initial;
  const factory GetListNewReleaseState.loading() = _Loading;
  const factory GetListNewReleaseState.loaded(BookList books) = _Loaded;
  const factory GetListNewReleaseState.error(Failure failure) = _Error;
}
