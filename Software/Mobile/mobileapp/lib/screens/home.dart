import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import 'package:kanga_care/core/util/const.dart';
import 'package:kanga_care/screens/bluetoothOff.dart';
import 'package:kanga_care/screens/components/babyprofile.dart';
import 'package:kanga_care/screens/components/babyreader.dart';
import 'package:kanga_care/screens/main_screen.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends StatefulWidget {
  Home(
      {super.key,
      this.adapterState,
      required this.device,
      required this.linkDevice,
      required this.widget});

  final BluetoothAdapterState? adapterState;
  final BluetoothDevice device;
  final Future<void> Function() linkDevice;
  final MainScreen widget;
  int count = 0;
  int historicalDataMin = 0;
  int historicalDataMax = 15;

  TextEditingController hostController =
      TextEditingController(text: Constants.deviceHost);
  TextEditingController schemeController =
      TextEditingController(text: Constants.deviceSchema);
  TextEditingController pathController =
      TextEditingController(text: Constants.devicePath);
  bool fetchData = false;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _HomeState() {}
  TooltipBehavior? _tooltipBehavior;
  Timer? timer;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    widget.count = 1;
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      const Tab(
        icon: Icon(
          Icons.child_care,
          size: 20,
        ),
        text: 'Reading',
      ),
      const Tab(
        icon: Icon(Icons.person, size: 20),
        text: 'Profile',
      ),
    ];

    final appState = Provider.of<AppState>(context);

    return widget.adapterState == BluetoothAdapterState.on
        ? DefaultTabController(
            length: tabs.length,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).colorScheme.surface,
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                      Helper.getScreenHeight(context) *
                          0.03), // Adjust the height as needed
                  child: TabBar(
                    tabs: tabs,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    labelStyle: const TextStyle(fontSize: 14.0),
                    labelColor:
                        appState.currentTheme.textTheme.headlineSmall?.color,
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  BabyReader(
                    widget: widget.widget,
                    context: context,
                    adapterState: widget.adapterState,
                    linkDevice: widget.linkDevice,
                  ),
                  BabyProfile(widget: widget.widget, context: context),
                ],
              ),
            ),
          )
        : BluetoothOff(
            adapterState: widget.adapterState,
          );
  }
}
