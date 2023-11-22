part of 'app_bloc.dart';

@Freezed()
class AppState with _$AppState {
  const factory AppState({
    @Default(UIInitial()) UIStatus status,
    @Default(false) bool isDarkMode,
    @Default(true) bool isFirstUse,
    @Default(null) User? user,
    @Default([]) List<LocalMedicine> medicines,
  }) = _AppState;
}
