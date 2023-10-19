import '../styling/text_styles_and_colors.dart';
import 'package:flutter/material.dart';

void customSnackBar({
  required ScaffoldMessengerState scaffoldKey,
  required String msg,
  double height = 30,
  required BuildContext context,
}) {
  if (scaffoldKey == null) {
    return;
  }
  // scaffoldKey.hideCurrentSnackBar();
  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Container(
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: CustomTextStyles.fontName),
      ),
    ),
  );

  scaffoldKey.showSnackBar(snackBar);
}
