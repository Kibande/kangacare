import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:provider/provider.dart';
import './home.dart';
import './label.dart';
import './notifications.dart';
import './Profile_And_Settings/profile.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  const MainScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  _MainScreenState() {
    timer = Timer.periodic(
        const Duration(milliseconds: 100), _refreshUserCredentials);
  }
  Timer? timer;
  late PageController _pageController;
  int _page = 0;

  List icons = [
    Icons.home,
    // Icons.label,
    // Icons.notifications,
    Icons.person,
  ];

  List pages = [
    Home(),
    // const Label(),
    // const Notifications(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: List.generate(pages.length, (index) => pages[index]),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildTabIcon(0),
              // buildTabIcon(1),
              // buildTabIcon(2),
              buildTabIcon(1),
            ],
          ),
        ));
  }

  void _refreshUserCredentials(Timer timer) {
    // debugPrint("Refreshing User Credentials");
  }

  // void navigationTapped(int page) {
  //    _pageController.jumpToPage(page);
  //  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    timer?.cancel();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

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
}
