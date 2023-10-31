/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your setting, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created setting or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/setting.dart';`
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medicare/theme/colors.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      primaryColor: colorScheme.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.blue,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.blueLight,
    onPrimaryContainer: AppColors.greyDark,
    secondary: AppColors.blue,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.blueLight,
    onSecondaryContainer: AppColors.greyDark,
    tertiary: AppColors.blueDark,
    onTertiary: AppColors.white,
    tertiaryContainer: AppColors.blueLight,
    background: AppColors.subtleGrey,
    onBackground: AppColors.black,
    surface: AppColors.subtleGrey,
    onSurface: AppColors.subtleBlack,
    error: AppColors.red,
    onError: AppColors.white,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: AppColors.blue,
    onPrimary: AppColors.white,
    primaryContainer: AppColors.blueLight,
    onPrimaryContainer: AppColors.greyDark,
    secondary: AppColors.greyDark,
    onSecondary: AppColors.white,
    secondaryContainer: AppColors.grey700,
    onSecondaryContainer: AppColors.white,
    tertiary: AppColors.blueDark,
    onTertiary: AppColors.greyLight,
    tertiaryContainer: AppColors.blueLight,
    background: AppColors.subtleBlack,
    onBackground: AppColors.white,
    surface: AppColors.subtleBlack,
    onSurface: AppColors.subtleWhite,
    error: AppColors.red,
    onError: AppColors.white,
    brightness: Brightness.dark,
  );

  static const _regular = FontWeight.w600;
  static const _medium = FontWeight.w600;
  static const _semiBold = FontWeight.w700;
  static const _bold = FontWeight.w800;
  static const _extraBold = FontWeight.w900;
  static const _letterSpacingHeadline = 0.3;
  static const _letterSpacingDisplay = 0.15;
  static const _letterSpacingCommon = 0.0;

  static final TextTheme _textTheme = TextTheme(
    headlineSmall: GoogleFonts.workSans(
      fontSize: 20,
      fontWeight: _semiBold,
      letterSpacing: _letterSpacingHeadline,
      color: AppColors.grey,
    ),
    headlineMedium: GoogleFonts.workSans(
      fontSize: 22,
      fontWeight: _bold,
      letterSpacing: _letterSpacingHeadline,
      color: AppColors.grey,
    ),
    headlineLarge: GoogleFonts.workSans(
      fontSize: 28,
      fontWeight: _extraBold,
      letterSpacing: _letterSpacingHeadline,
      color: AppColors.grey,
    ),
    displaySmall: GoogleFonts.workSans(
      fontSize: 14,
      fontWeight: _regular,
      letterSpacing: _letterSpacingDisplay,
      color: AppColors.black,
    ),
    displayMedium: GoogleFonts.workSans(
      fontSize: 16,
      fontWeight: _medium,
      letterSpacing: _letterSpacingDisplay,
      color: AppColors.black,
    ),
    displayLarge: GoogleFonts.workSans(
      fontSize: 18,
      fontWeight: _semiBold,
      letterSpacing: _letterSpacingDisplay,
      color: AppColors.black,
    ),
    bodySmall: GoogleFonts.workSans(
      fontSize: 12,
      fontWeight: _regular,
      color: AppColors.black,
    ),
    bodyMedium: GoogleFonts.workSans(
      fontSize: 14,
      fontWeight: _regular,
      color: AppColors.black,
    ),
    bodyLarge: GoogleFonts.workSans(
      fontSize: 16,
      fontWeight: _regular,
      color: AppColors.black,
    ),
    labelSmall: GoogleFonts.workSans(
      fontSize: 10,
      fontWeight: _regular,
      letterSpacing: _letterSpacingCommon,
      color: AppColors.black,
    ),
    labelMedium: GoogleFonts.workSans(
      fontSize: 12,
      fontWeight: _regular,
      letterSpacing: _letterSpacingCommon,
      color: AppColors.black,
    ),
    labelLarge: GoogleFonts.workSans(
      fontSize: 14,
      fontWeight: _regular,
      letterSpacing: _letterSpacingCommon,
      color: AppColors.black,
    ),
    titleSmall: GoogleFonts.workSans(
      fontSize: 10,
      fontWeight: _semiBold,
      letterSpacing: _letterSpacingCommon,
      color: AppColors.black,
    ),
    titleMedium: GoogleFonts.workSans(
      fontSize: 12,
      fontWeight: _semiBold,
      letterSpacing: _letterSpacingCommon,
      color: AppColors.black,
    ),
    titleLarge: GoogleFonts.workSans(
      fontSize: 14,
      fontWeight: _semiBold,
      letterSpacing: _letterSpacingCommon,
      color: AppColors.black,
    ),
  );
}
