import 'package:kanga_care/core/util/const.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:share/share.dart';

import '../../features/user_authentication/presentation/pages/landingScreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../core/app_state.dart';

import './components/account_info_widget.dart';
import 'components/account_page_list_item.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  Future logout() async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.resetAppStates();
    Navigator.of(context).pushNamedAndRemoveUntil(
        LandingScreen.routeName, (Route<dynamic> route) => false);
  }

  Future resetApp() async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.resetAppStates();
    Navigator.of(context).pushNamedAndRemoveUntil(
        LandingScreen.routeName, (Route<dynamic> route) => false);
  }

  addAllListData(BuildContext context) {
    // final appState = Provider.of<AppState>(context);
    final List<AccountPageListItem> settingsitems = [
      AccountPageListItem(
          title: "Help",
          icon: const Icon(
            Icons.info,
            color: Colors.blue,
          ),
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Container(
                            height: Helper.getScreenHeight(context) * 0.55,
                            width: Helper.getScreenWidth(context) * 0.9,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Column(children: [
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Help Info",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.color,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontSize,
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontWeight,
                                    ),
                                  ),
                                )),
                                const Divider(
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                        '''Connect the application to the Kanga Care devices bluetooth network.\n\nThis will enable the mobile application read values from the device.\n\nIncase this fails seek technical help.
                                        ''',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          wordSpacing: 3,
                                        )),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ))
              }),
      AccountPageListItem(
          title: "Share App",
          icon: const Icon(
            Icons.share,
            color: Colors.purple,
          ),
          onPressed: () => {Share.share(Constants.googlePlayLink)}),
      AccountPageListItem(
          title: "Terms of Service",
          icon: const Icon(
            Icons.receipt,
            color: Colors.blueGrey,
          ),
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Container(
                            height: Helper.getScreenHeight(context) * 0.35,
                            width: Helper.getScreenWidth(context) * 0.9,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Column(children: [
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Terms and Conditions",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.color,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontSize,
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontWeight,
                                    ),
                                  ),
                                )),
                                const Divider(
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                        '''This is a protoype application, meant to be used under technical supervision.\n\nProperty of Buri Care
                                        ''',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          wordSpacing: 3,
                                        )),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ))
              }),
      AccountPageListItem(
          title: "Reset App",
          icon: const Icon(
            Icons.clear,
            color: Colors.lime,
          ),
          onPressed: resetApp),
      AccountPageListItem(
          title: "Logout",
          icon: const Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
          onPressed: logout),
    ];

    for (var i = 0; i < settingsitems.length; i++) {
      listViews.add(settingsitems[i]);
    }
  }

  @override
  void initState() {
    addAllListData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const AccountInfoWidget(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.58,
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.only(
              top: 0,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listViews[index];
            },
          ),
        )
      ],
    );
  }
}
