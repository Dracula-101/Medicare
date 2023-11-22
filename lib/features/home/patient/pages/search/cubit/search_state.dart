part of 'search_cubit.dart';

// initial state
@freezed
abstract class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded({required MedicineSearchResult result}) =
      _Loaded;
  const factory SearchState.error({required Exception error}) = _Error;
}
