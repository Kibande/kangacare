import 'package:flutter/material.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import '../const/colors.dart';

class CustomAppThemes {
  static ThemeData lightTheme = ThemeData(
      fontFamily: "Metropolis",
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 128, 0, 0),
          onPrimary: Colors.white,
          secondary: Color.fromARGB(255, 9, 15, 86),
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.white,
          onSurface: Colors.black,
          tertiary: Color.fromARGB(255, 234, 234, 234)),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Colors.black,
          fontFamily: CustomTextStyles.fontName,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          fontFamily: CustomTextStyles.fontName,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.5,
        ),
        headlineLarge: TextStyle(
          color: Colors.black,
          fontFamily: CustomTextStyles.fontName,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontSize: 25,
        ),
        bodyMedium: TextStyle(
          color: AppColor.secondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 128, 0, 0),
          ),
          foregroundColor: WidgetStateProperty.all(
            Colors.white,
          ),
          overlayColor: WidgetStateProperty.all(
            const Color.fromARGB(255, 59, 1, 1),
          ),
          shape: WidgetStateProperty.all(
            const StadiumBorder(),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white));

  static ThemeData darkTheme = ThemeData(
      fontFamily: "Metropolis",
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.purple,
        onPrimary: Colors.white,
        secondary: Colors.green,
        onSecondary: Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        surface: Color.fromARGB(255, 40, 39, 39),
        onSurface: Color.fromARGB(255, 208, 208, 208),
        tertiary: Color.fromARGB(255, 26, 25, 25),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Colors.white,
          fontFamily: CustomTextStyles.fontName,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
        headlineMedium: TextStyle(
          color: Colors.white,
          fontFamily: CustomTextStyles.fontName,
          fontWeight: FontWeight.w500,
          fontSize: 18,
          letterSpacing: 0.5,
        ),
        headlineLarge: TextStyle(
          color: Colors.white,
          fontFamily: CustomTextStyles.fontName,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
          fontSize: 25,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            Colors.purple,
          ),
          foregroundColor: WidgetStateProperty.all(
            Colors.white,
          ),
          shape: WidgetStateProperty.all(
            const StadiumBorder(),
          ),
          elevation: WidgetStateProperty.all(0),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white));
}
