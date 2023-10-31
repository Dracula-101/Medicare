abstract class AppService {
  bool get isDarkMode;
  bool get isFirstUse;

  Future<void> setIsDarkMode({
    required bool darkMode,
  });

  Future<void> setIsFirstUse({
    required bool isFirstUse,
  });
}
