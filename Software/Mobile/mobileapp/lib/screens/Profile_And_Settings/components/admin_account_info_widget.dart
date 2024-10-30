import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/app_state.dart';
import '../../../core/app_themes.dart';
import '../../../utils/helper.dart';

class AdminAccountInfoWidget extends StatelessWidget {
  const AdminAccountInfoWidget({super.key, required this.uploadImage});
  final Future<void> Function() uploadImage;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
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
          SizedBox(
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: <Widget>[
                ClipOval(
                  child: CircleAvatar(
                    radius: Helper.getScreenWidth(context) * .12,
                    child: appState.getAdminPicUrl.contains("assets/images")
                        ? Image.asset(appState.getAdminPicUrl)
                        : Image.file(File(appState.getAdminPicUrl)),
                  ),
                ),
                GestureDetector(
                    child: Container(
                      width: Helper.getScreenWidth(context) * 0.075,
                      height: Helper.getScreenWidth(context) * 0.075,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Helper.getTheme(context).bodySmall?.color,
                      ),
                    ),
                    onTap: () => {uploadImage()}),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            // ignore: prefer_const_constructors
            child: Column(
              children: const [
                Text(
                  "KIbande Steven",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                ),
                Text(
                  "ID: 236728",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
