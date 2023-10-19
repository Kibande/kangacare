import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:kanga_care/features/user_authentication/presentation/bloc/bloc.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import 'package:kanga_care/core/widgets/request_for_user_input.dart';
import 'package:kanga_care/core/util/const.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class Home extends StatefulWidget {
  Widget netWorkMessage = const Text(
    "Offline",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.red,
        fontSize: 16.0,
        fontFamily: CustomTextStyles.fontName),
  );
  Home({super.key});
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
  _HomeState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
  }
  TooltipBehavior? _tooltipBehavior;
  Timer? timer;
  List<_ChartData> liveData = <_ChartData>[];
  List<_ChartData> historicalData = <_ChartData>[];
  ChartSeriesController? _liveDataSeriesController;
  ChartSeriesController? _historicalDataSeriesController;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    widget.count = 1;
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    liveData.clear();
    historicalData.clear();
    _liveDataSeriesController = null;
    _historicalDataSeriesController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = [
      const Tab(
        icon: Icon(Icons.graphic_eq, size: 10),
        text: 'Graph',
      ),
      const Tab(
        icon: Icon(Icons.data_usage, size: 10),
        text: 'Value',
      ),
    ];

    final appState = Provider.of<AppState>(context);

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Helper.getScreenHeight(context) *
                0.05), // Adjust the height as needed
            child: TabBar(
              tabs: tabs,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: const EdgeInsets.symmetric(vertical: 0.0),
              labelStyle: const TextStyle(fontSize: 14.0),
              labelColor: appState.currentTheme.textTheme.headline3?.color,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            graphTab(),
            valueTab(),
          ],
        ),
      ),
    );
    ;
  }

  Future<http.Response> _makeFetchReadingsFromDevice() async {
    var res;
    final client = http.Client();
    try {
      res = await client.get(
        Uri(
            scheme: widget.schemeController.text,
            host: widget.hostController.text,
            path: widget.pathController.text),
        headers: {'content-type': 'application/json'},
      );
      // ignore: empty_catches
    } catch (e) {}
    client.close();
    return res;
  }

  void _updateDataSource(Timer timer) {
    _makeFetchReadingsFromDevice().then((result) {
      Map data = json.decode(result.body);
      _ChartData newData = _ChartData(widget.count, data['temperature']);
      liveData.add(newData);
      historicalData.add(newData);
      //for live data
      if (liveData.length == 20) {
        liveData.removeAt(0);
        _liveDataSeriesController?.updateDataSource(
          addedDataIndexes: <int>[liveData.length - 1],
          removedDataIndexes: <int>[0],
        );
      } else {
        _liveDataSeriesController?.updateDataSource(
          addedDataIndexes: <int>[liveData.length - 1],
        );
      }

      if (historicalData.length < 20) {
        //for historical data
        _historicalDataSeriesController?.updateDataSource(
            addedDataIndexes: <int>[historicalData.length - 1]);
        setState(() {
          widget.historicalDataMax = historicalData.length - 1;
          widget.historicalDataMin = 0;
        });
      } else {
        //for historical data
        _historicalDataSeriesController?.updateDataSource(
          addedDataIndexes: <int>[widget.historicalDataMax],
          removedDataIndexes: <int>[widget.historicalDataMin],
        );
      }
      setState(() {
        widget.count = widget.count + 1;

        widget.netWorkMessage = const Text(
          "Online",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.green,
              fontSize: 16.0,
              fontFamily: CustomTextStyles.fontName),
        );
      });
    }, onError: (error) {
      // causing errors log in terminal
      // setState(() {
      //   widget.netWorkMessage = const Text(
      //     "Offline",
      //     textAlign: TextAlign.center,
      //     style: TextStyle(
      //         color: Colors.red,
      //         fontSize: 16.0,
      //         fontFamily: CustomTextStyles.fontName),
      //   );
      // });
    });
  }

  Widget graphTab() {
    return Center(
      child: SizedBox(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: ListView(
          children: [
            SizedBox(
              height: Helper.getScreenHeight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Center(child: Text('Status: ')),
                      widget.netWorkMessage,
                    ],
                  ),
                ),
                GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.settings, color: Colors.blue),
                  ),
                  onTap: () {
                    requestUserPasscode(
                        hostController: widget.hostController,
                        pathController: widget.pathController,
                        schemeController: widget.schemeController,
                        processFunction: () => {
                              // setState(
                              // () => {

                              // })
                            },
                        fetchData: widget.fetchData,
                        liveFetchFunc: (newValue) => {
                              // setState(() => {widget.fetchData = newValue}),
                              debugPrint(newValue.toString())
                            },
                        context: context);
                  },
                )
              ],
            ),
            SizedBox(
              height: Helper.getScreenHeight(context) * 0.01,
            ),
            Center(
                child: Text(
              'Live Data',
              style: Helper.getTheme(context).headlineMedium,
            )),
            SizedBox(
              height: Helper.getScreenHeight(context) * 0.3,
              width: Helper.getScreenWidth(context) * .9,
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 0)),
                  series: <LineSeries<_ChartData, int>>[
                    LineSeries<_ChartData, int>(
                      onRendererCreated: (ChartSeriesController controller) {
                        _liveDataSeriesController = controller;
                      },
                      dataSource: liveData,
                      color: const Color.fromRGBO(192, 108, 132, 1),
                      xValueMapper: (_ChartData sales, _) => sales.country,
                      yValueMapper: (_ChartData sales, _) => sales.sales,
                      animationDuration: 0,
                    )
                  ]),
            ),
            Center(
              child: Text(
                'Historical Data',
                style: Helper.getTheme(context).headlineMedium,
              ),
            ),
            SizedBox(
              height: Helper.getScreenHeight(context) * 0.3,
              width: Helper.getScreenWidth(context),
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: NumericAxis(
                      majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 0)),

                  // Enable tooltip
                  tooltipBehavior: _tooltipBehavior,
                  series: <LineSeries<_ChartData, int>>[
                    LineSeries<_ChartData, int>(
                        onRendererCreated: (ChartSeriesController controller) {
                          _historicalDataSeriesController = controller;
                        },
                        dataSource: historicalData.isNotEmpty
                            ? historicalData.sublist(widget.historicalDataMin,
                                widget.historicalDataMax)
                            : historicalData,
                        color: const Color.fromARGB(255, 34, 66, 248),
                        xValueMapper: (_ChartData sales, _) => sales.country,
                        yValueMapper: (_ChartData sales, _) => sales.sales,
                        animationDuration: 0,

                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_circle_left, color: Colors.red),
                      ),
                      onDoubleTap: () {
                        if ((widget.historicalDataMin - 100 >= 0)) {
                          setState(() {
                            widget.historicalDataMax =
                                widget.historicalDataMax - 100;

                            widget.historicalDataMin =
                                widget.historicalDataMin - 100;
                          });
                        }
                      },
                      onTap: () {
                        if ((widget.historicalDataMin - 2 >= 0)) {
                          setState(() {
                            widget.historicalDataMax =
                                widget.historicalDataMax - 2;

                            widget.historicalDataMin =
                                widget.historicalDataMin - 2;
                          });
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            Icon(Icons.arrow_circle_right, color: Colors.green),
                      ),
                      onDoubleTap: () {
                        if ((widget.historicalDataMax + 100 <
                            historicalData.length - 1)) {
                          setState(() {
                            widget.historicalDataMax =
                                widget.historicalDataMax + 100;

                            widget.historicalDataMin =
                                widget.historicalDataMin + 100;
                          });
                        }
                      },
                      onTap: () {
                        if ((widget.historicalDataMax + 2 <
                            historicalData.length - 1)) {
                          setState(() {
                            widget.historicalDataMax =
                                widget.historicalDataMax + 2;

                            widget.historicalDataMin =
                                widget.historicalDataMin + 2;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget valueTab() {
    String currentValue =
        liveData.length > 0 ? liveData.last.sales.toString() : '--';
    return Center(
      child: SizedBox(
        height: Helper.getScreenHeight(context) * 0.5,
        child: Column(
          children: [
            Center(
              child: Text(
                'Current Temperature',
                style: Helper.getTheme(context).headlineMedium,
              ),
            ),
            SizedBox(
              height: Helper.getScreenHeight(context) * 0.1,
            ),
            Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  '$currentValue',
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.country, this.sales);
  final int country;
  final num sales;
}
