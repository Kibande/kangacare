import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:provider/provider.dart';

import 'landingScreen.dart';
import '../../../../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 4000), () {
      Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              // child: Image.asset(
              //   Helper.getAssetName("splashIcon.png", "virtual"),
              //   fit: BoxFit.fill,
              // ),
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                Helper.getAssetName(
                    Theme.of(context).brightness == Brightness.light
                        ? "logo.png"
                        : "black_and_white_logo.png",
                    "virtual"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
