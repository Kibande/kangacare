import 'package:flutter/material.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:provider/provider.dart';
import '../screens/components/notification_list_item.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    listViews.add(const NotifcationListWidget(
        title: "Connected",
        body:
            "Successfully connected Successfully connected Successfully connected Successfully connected Successfully connected Successfully connected Successfully connected",
        time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Disconnected", body: "Connection lost", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));

    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
    listViews.add(const NotifcationListWidget(
        title: "Connected", body: "Successfully connected", time: "27.12.22"));
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appState.currentTheme.colorScheme.surface,
        title: Center(
            child: Text(
          "Notifications",
          style: TextStyle(
            color: appState.currentTheme.textTheme.headline4?.color,
            fontSize: appState.currentTheme.textTheme.headline4?.fontSize,
            fontWeight: appState.currentTheme.textTheme.headline4?.fontWeight,
          ),
        )),
        automaticallyImplyLeading: false,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
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
      ),
    );
  }
}
