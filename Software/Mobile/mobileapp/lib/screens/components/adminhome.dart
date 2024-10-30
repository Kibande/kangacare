import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import 'package:kanga_care/screens/components/babyCard.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatefulWidget {
  AdminHome({super.key});
  String? searchText = "";
  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Widget searchBarComponent() {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.only(left: 8.0),
      child: TextField(
        cursorColor: Theme.of(context).primaryColor,
        onChanged: (val) {
          setState(() {
            widget.searchText = val;
          });
        },
        decoration: const InputDecoration(
          hintText: "Search",
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.search,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Column(
      children: [
        SizedBox(
          height: Helper.getScreenHeight(context) * 0.05,
        ),
        SizedBox(
            height: Helper.getScreenHeight(context) * 0.09,
            child: searchBarComponent()),
        Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context) * 0.78,
          child: ListView(
            children: [
              BabyCard(
                  babyName: "Smith",
                  babyTemp: "34*C",
                  babyState: "Normal",
                  babyPicUrl: appState.getAdminPicUrl,
                  babyBirthWeight: "345grms",
                  babyBirthTime: "09:56 AM",
                  babyBirthDate: "01/01/2024",
                  babyContactName1: "John",
                  babyContactTel1: "+234 345 232 232",
                  babyContactName2: "Jane",
                  babyContactTel2: "+256 789 345 234")
            ],
          ),
        )
      ],
    );
  }
}
