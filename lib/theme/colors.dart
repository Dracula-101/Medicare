import 'package:flutter/widgets.dart';

class AppColors {
  AppColors._();

  static const Color blue = Color(0xFF1648CE);
  static const Color blueLight = Color(0xFFA5BCE7);
  static const Color blueDark = Color(0xFF091F44);

  static const Map<int, Color> blueShades = {
    50: Color(0xFFE6EAF9),
    100: Color(0xFFC0C9F0),
    200: Color(0xFF98A2E7),
    300: Color(0xFF6F7BDE),
    400: Color(0xFF4A57D6),
    500: Color(0xFF243FD0),
    600: Color(0xFF1F39C7),
    700: Color(0xFF1A32BE),
    800: Color(0xFF162AB5),
    900: Color(0xFF0D1BA6),
  };

  static const Map<int, Color> greyShades = {
    50: Color(0xFFF2F4F7),
    100: Color(0xFFE4E8EF),
    200: Color(0xFFB9C0CD),
    300: Color(0xFF929CAD),
    400: Color(0xFF6A788E),
    500: Color(0xFF394D6D),
    600: Color(0xFF394D6D),
    700: Color(0xFF394D6D),
    800: Color(0xFF243145),
    900: Color(0xFF192234),
  };

  static const Color grey50 = Color(0xFFF2F4F7);
  static const Color grey100 = Color(0xFFE4E8EF);
  static const Color grey200 = Color(0xFFB9C0CD);
  static const Color grey300 = Color(0xFF929CAD);
  static const Color grey400 = Color(0xFF6A788E);
  static const Color grey500 = Color(0xFF394D6D);
  static const Color grey600 = Color(0xFF394D6D);
  static const Color grey700 = Color(0xFF394D6D);
  static const Color grey800 = Color(0xFF243145);
  static const Color grey900 = Color(0xFF192234);
  static const Color grey = Color(0xFF394D6D);
  static const Color greyDark = Color(0xFF243145);
  static const Color greyLight = Color(0xFF929CAD);

  static const Color subtleGrey = Color(0xFFFAFAFE);
  
  static const Color white = Color(0xFFFFFFFF);
  static const Color subtleWhite = Color(0xFFE5E5E5);
  static const Color black = Color(0xFF000000);
  static const Color subtleBlack = Color(0xFF1A1A1A);

  static const Color red = Color(0xFFE35F47);
  static const Color green = Color(0xFF18B055);
  static const Color orange = Color(0xFFEF802F);
}
