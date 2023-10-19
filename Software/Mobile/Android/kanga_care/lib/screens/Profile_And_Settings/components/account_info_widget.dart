import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_state.dart';
import '../../../core/app_themes.dart';
import '../../../utils/helper.dart';

class AccountInfoWidget extends StatelessWidget {
  const AccountInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15)],
          borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                appState.toggleTheme();
              },
              icon: appState.currentTheme == CustomAppThemes.lightTheme
                  ? const Icon(Icons.brightness_2)
                  : const Icon(Icons.wb_sunny),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    Helper.getAssetName("black_and_white_logo.png", "virtual"),
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: const Text(
              "Kanga Care",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
