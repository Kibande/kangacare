import 'package:flutter/material.dart';
import 'package:kanga_care/features/user_authentication/presentation/pages/signUpScreen.dart';
import 'package:kanga_care/screens/admin_screen.dart';
import 'package:kanga_care/screens/main_screen.dart';
import 'loginScreen.dart';

import '../../../../utils/helper.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = "/landingScreen";

  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: Helper.getScreenWidth(context),
      height: Helper.getScreenHeight(context),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.5,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: Helper.getScreenWidth(context) * 0.8,
              height: Helper.getScreenHeight(context) * 0.3,
              child: Image.asset(
                Helper.getAssetName(
                    Theme.of(context).brightness == Brightness.light
                        ? "logo.png"
                        : "black_and_white_logo.png",
                    "virtual"),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: Helper.getScreenHeight(context) * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // Navigator.of(context).pushNamed(LoginScreen.routeName);
                  //       Navigator.of(context).pushNamed(AdminScreen.routeName);
                  //     },
                  //     child: const Text(
                  //       "Login",
                  //       style: TextStyle(color: Colors.white),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   height: 50,
                  //   child: ElevatedButton(
                  //     style: ButtonStyle(
                  //       backgroundColor: WidgetStateProperty.all(Colors.white),
                  //       foregroundColor: WidgetStateProperty.all(
                  //           Theme.of(context).colorScheme.primary),
                  //       shape: WidgetStateProperty.all(
                  //         StadiumBorder(
                  //           side: BorderSide(
                  //               color: Theme.of(context).colorScheme.primary),
                  //         ),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.of(context).pushNamed(SignUpScreen.routeName);
                  //     },
                  //     child: const Text("Create an Account"),
                  //   ),
                  // ),
                  // const Spacer(
                  //   flex: 2,
                  // ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(MainScreen.routeName);
                      },
                      child: const Text(
                        "Local Connection",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomClipperAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width * 0.24, size.height);
    Offset endPoint = Offset(size.width * 0.25, size.height * 0.96);
    Offset controlPoint2 = Offset(size.width * 0.3, size.height * 0.78);
    Offset endPoint2 = Offset(size.width * 0.5, size.height * 0.78);
    Offset controlPoint3 = Offset(size.width * 0.7, size.height * 0.78);
    Offset endPoint3 = Offset(size.width * 0.75, size.height * 0.96);
    Offset controlPoint4 = Offset(size.width * 0.76, size.height);
    Offset endPoint4 = Offset(size.width * 0.79, size.height);
    Path path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.21, size.height)
      ..quadraticBezierTo(
        controlPoint.dx,
        controlPoint.dy,
        endPoint.dx,
        endPoint.dy,
      )
      ..quadraticBezierTo(
        controlPoint2.dx,
        controlPoint2.dy,
        endPoint2.dx,
        endPoint2.dy,
      )
      ..quadraticBezierTo(
        controlPoint3.dx,
        controlPoint3.dy,
        endPoint3.dx,
        endPoint3.dy,
      )
      ..quadraticBezierTo(
        controlPoint4.dx,
        controlPoint4.dy,
        endPoint4.dx,
        endPoint4.dy,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
