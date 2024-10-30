import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kanga_care/screens/Profile_And_Settings/admin_profile.dart';
import 'package:kanga_care/screens/components/adminhome.dart';
import 'package:kanga_care/utils/helper.dart';

// ignore: must_be_immutable
class AdminScreen extends StatefulWidget {
  static const routeName = '/adminScreen';

  const AdminScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  _AdminScreenState();

  late PageController _pageController;
  int _page = 0;

  List icons = [
    Icons.home,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    List pages = [AdminHome(), const AdminProfile()];

    buildTabIcon(int index) {
      return Container(
        margin: EdgeInsets.fromLTRB(
            index == pages.length - 1 ? 30 : 0, 0, index == 1 ? 30 : 0, 0),
        child: IconButton(
          icon: Icon(
            icons[index],
            size: 24.0,
          ),
          color: _page == index
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).focusColor,
          onPressed: () => _pageController.jumpToPage(index),
        ),
      );
    }

    return ScaffoldMessenger(
      child: Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: onPageChanged,
            children: List.generate(pages.length, (index) => pages[index]),
          ),
          bottomNavigationBar: BottomAppBar(
            height: Helper.getScreenHeight(context) * 0.08,
            color: Theme.of(context).colorScheme.tertiary,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildTabIcon(0),
                buildTabIcon(1),
              ],
            ),
          )),
    );
  }

  void _refreshUserCredentials(Timer timer) {}

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
