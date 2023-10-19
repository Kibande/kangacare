import 'package:flutter/material.dart';
import '../const/colors.dart';

class CustomAppThemes {
  static ThemeData lightTheme = ThemeData(
      fontFamily: "Metropolis",
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.blue,
        onPrimary: Colors.blue,
        secondary: Colors.green,
        onSecondary: Colors.green,
        error: Colors.red,
        onError: Colors.red,
        background: Colors.grey,
        onBackground: Colors.grey,
        surface: Colors.white,
        onSurface: Colors.white,
      ),
      textTheme: const TextTheme(
        headline3: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        headline5: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontSize: 25,
        ),
        headline6: TextStyle(
          color: Colors.black,
          fontSize: 25,
        ),
        bodyText2: TextStyle(
          color: AppColor.secondary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.blue,
          ),
          shape: MaterialStateProperty.all(
            const StadiumBorder(),
          ),
          elevation: MaterialStateProperty.all(0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            AppColor.green,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white));

  static ThemeData darkTheme = ThemeData(
      fontFamily: "Metropolis",
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.purple,
        onPrimary: Colors.purple,
        secondary: Colors.teal,
        onSecondary: Colors.teal,
        error: Colors.red,
        onError: Colors.red,
        background: Colors.grey,
        onBackground: Colors.grey,
        surface: Colors.black,
        onSurface: Colors.black,
      ),
      textTheme: const TextTheme(
        headline3: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        headline4: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        headline5: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 25,
        ),
        headline6: TextStyle(
          color: Colors.white,
          fontSize: 25,
        ),
        bodyText2: TextStyle(
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.purple,
          ),
          shape: MaterialStateProperty.all(
            const StadiumBorder(),
          ),
          elevation: MaterialStateProperty.all(0),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(
            AppColor.green,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white));
}
