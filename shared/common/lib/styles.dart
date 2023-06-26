import 'package:dependencies/google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Styles {
  // colors
  static const kRichBlack = Color(0xFF000814);
  static const kOxfordBlue = Color(0xFF001D3D);
  static const kPrussianBlue = Color(0xFF003566);
  static const kMikadoYellow = Color(0xFFffc300);
  static const kDavysGrey = Color(0xFF4B5358);
  static const kGrey = Color(0xFF303030);

  // text style
  static TextStyle kHeading5 = GoogleFonts.poppins(
    fontSize: 23,
    fontWeight: FontWeight.w400,
  );
  static TextStyle kHeading6 = GoogleFonts.poppins(
    fontSize: 19,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  );
  static TextStyle kSubtitle = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  );
  static TextStyle kBodyText = GoogleFonts.poppins(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  // text theme
  static TextTheme kTextTheme = TextTheme(
    headlineSmall: kHeading5,
    titleLarge: kHeading6,
    titleMedium: kSubtitle,
    bodyMedium: kBodyText,
  );

  static const kColorScheme = ColorScheme(
    primary: kMikadoYellow,
    primaryContainer: kMikadoYellow,
    secondary: kPrussianBlue,
    secondaryContainer: kPrussianBlue,
    surface: kRichBlack,
    background: kRichBlack,
    error: Colors.red,
    onPrimary: kRichBlack,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
    onError: Colors.white,
    brightness: Brightness.dark,
  );
}
