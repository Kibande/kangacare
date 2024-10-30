import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomColors {
  static const Color BackgroundColor = Color.fromRGBO(240, 244, 247, 1);

  static const Color Purple = Color.fromRGBO(126, 0, 252, 1);
  static const Color Turquoise = Color.fromRGBO(64, 224, 208, 1);
  static const Color PaleTurquoise = Color.fromRGBO(175, 238, 238, 1);
  static const Color MediumTurquoise = Color.fromRGBO(72, 209, 204, 1);
  static const Color DarkTurquoise = Color.fromRGBO(0, 206, 209, 1);
  static const Color Purple02 = Color.fromRGBO(126, 0, 252, 0.02);
  static const Color PurpleLight = Color.fromRGBO(243, 229, 255, 1);
  static const Color PurpleLightText = Color.fromRGBO(187, 184, 234, 1);

  static const Color BlueLightBorder = Color.fromRGBO(192, 213, 229, 1);
  static const Color BlueIcon = Color.fromRGBO(0, 122, 255, 1);
  static const Color GreyText = Color.fromRGBO(129, 129, 129, 1);
  static const Color GreyTextLight = Color.fromRGBO(201, 200, 200, 1);
  static const Color GreyTextLightExtra = Color.fromRGBO(235, 235, 235, 1);
  static const Color GreenText = Color.fromRGBO(0, 175, 81, 1);

  static const Color CardVisaPurple = Color.fromRGBO(206, 54, 183, 1);
  static const Color RedText = Color.fromRGBO(255, 54, 54, 1);
  static const Color CardVisaIndigo = Color.fromRGBO(50, 40, 123, 1);
  static const Color CardMastercardGrey = Color.fromRGBO(132, 132, 132, 1);
  static const Color CardMastercardBlack = Color.fromRGBO(1, 1, 2, 1);
  static const Color CardVisaPurple2 = Color.fromRGBO(121, 75, 255, 1);
  static const Color CardVisaPurple3 = Color.fromRGBO(50, 40, 123, 1);
  static const Color CardBlueLight = Color.fromRGBO(83, 166, 248, 1);
  static const Color CardBlueDark = Color.fromRGBO(12, 53, 83, 1);
}

class CustomTextStyles {
  static const String fontName = 'WorkSans';
  static const TextStyle WarningText = TextStyle(color: CustomColors.RedText);
  static const TextStyle ButtonText =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 20);
  static const TextStyle Purple16 =
      TextStyle(fontSize: 16, color: CustomColors.Purple, letterSpacing: 1);
  static const TextStyle Grey16 =
      TextStyle(fontSize: 16, color: CustomColors.GreyText, letterSpacing: 1);
  static const TextStyle LargePurpleLight = TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: CustomColors.PurpleLightText);

  static const TextStyle OnBoarding = TextStyle(
      fontSize: 25, fontFamily: fontName, fontWeight: FontWeight.w300);

  static const TextStyle White16 = TextStyle(color: Colors.white, fontSize: 16);
  static const TextStyle Bold14 =
      TextStyle(fontSize: 14, letterSpacing: 1, fontWeight: FontWeight.w600);
  static const TextStyle SemiBold18 =
      TextStyle(fontWeight: FontWeight.w500, fontSize: 18);
  static const TextStyle GreyText16 =
      TextStyle(fontSize: 16, color: CustomColors.GreyText);

  static const TextStyle SubscriptionNumber =
      TextStyle(fontSize: 12, fontWeight: FontWeight.w800);
  static const TextStyle CardHolder =
      TextStyle(color: Colors.white54, letterSpacing: 0.3, fontSize: 14);
  static const TextStyle CardName =
      TextStyle(color: Colors.white, fontSize: 14, letterSpacing: 0.3);
  static const TextStyle CardNumber = TextStyle(
      color: Colors.white,
      fontFamily: fontName,
      fontWeight: FontWeight.w500,
      letterSpacing: 5.5);
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class CustomIcons {
  static const IconData addIcon = const IconData(62601,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);
  static const IconData searchIcon = const IconData(62629,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage);
}

class CustomImages {
  static const String starFilled = 'assets/images/icon-star-filled.png';
  static const String starEmpty = 'assets/images/icon-star-empty.png';
}

class CustomAppThemes {
  static Color lightPrimary = CustomColors.DarkTurquoise;
  static Color darkPrimary = CustomColors.Purple;
  static const Color lightAccent = Color(0xFFF2F3F8);
  static const Color darkAccent = Color(0xFF364A54);
  static Color lightBG = const Color(0xfffcfcff);
  static Color darkBG = nearlyBlack;
  static Color badgeColor = Colors.red;
  static Color lightgrey = const Color.fromRGBO(241, 241, 241, 1);

  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'WorkSans';

  static const TextStyle lightDisplay1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: nearlyBlack,
  );
  static const TextStyle lightDisplay2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkAccent,
  );
  static const TextStyle darkDisplay1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: nearlyWhite,
  );
  static const TextStyle darkDisplay2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: lightAccent,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: Color(0xFF929091),
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );

  static const TextTheme lightTextTheme = TextTheme(
    headlineSmall: lightDisplay1,
    headlineMedium: lightDisplay2,
    bodyMedium: body2,
    bodySmall: body1,
  );
  static const TextTheme darkTextTheme = TextTheme(
    headlineSmall: darkDisplay1,
    headlineMedium: darkDisplay2,
    bodySmall: body1,
    bodyMedium: body2,
  );

  static ThemeData lightTheme = ThemeData(
    dialogBackgroundColor: lightBG,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightBG,
    textTheme: lightTextTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      toolbarTextStyle: TextTheme(
        bodyMedium: TextStyle(
          color: darkBG,
          fontSize: 20.0,
          fontFamily: fontName,
          fontWeight: FontWeight.w800,
        ),
      ).bodyMedium,
      titleTextStyle: TextTheme(
        bodySmall: TextStyle(
          color: darkBG,
          fontSize: 20.0,
          fontFamily: fontName,
          fontWeight: FontWeight.w800,
        ),
      ).headlineMedium,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    dialogBackgroundColor: darkBG,
    primaryColor: darkPrimary,
    hintColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    textTheme: darkTextTheme,
    appBarTheme: AppBarTheme(
      elevation: 0,
      //iconTheme: darkTextTheme,
    ),
  );
}
