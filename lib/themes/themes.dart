import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF878787);
  static const Color darkBrown = Color(0xFFB64B32);
  static const Color lightGrey = Color(0xFFC8C8C8);
  static const Color orangeBrown = Color(0xFFDF8031);
  static const Color offWhite = Color(0xFFF2F2F2);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: darkBrown,
    scaffoldBackgroundColor: offWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBrown,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: black, fontSize: 18, fontFamily: GoogleFonts.poppins().fontFamily),
      bodyMedium: TextStyle(color: grey, fontSize: 16, fontFamily: GoogleFonts.poppins().fontFamily,),
      labelLarge: TextStyle(color: darkBrown, fontSize: 60, fontWeight: FontWeight.bold, fontFamily: GoogleFonts.poppins().fontFamily),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: darkBrown,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkBrown,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: darkBrown,
      onPrimary: Colors.white,
      secondary: orangeBrown,
      onSecondary: Colors.white,
      background: offWhite,
      onBackground: black,
      surface: Colors.white,
      onSurface: black,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkBrown,
    scaffoldBackgroundColor: black,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkBrown,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: offWhite, fontSize: 18),
      bodyMedium: TextStyle(color: lightGrey, fontSize: 16),
      labelLarge: TextStyle(color: orangeBrown, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: orangeBrown,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: orangeBrown,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: darkBrown,
      onPrimary: Colors.white,
      secondary: orangeBrown,
      onSecondary: Colors.white,
      background: black,
      onBackground: offWhite,
      surface: Colors.black,
      onSurface: lightGrey,
    ),
  );
}
