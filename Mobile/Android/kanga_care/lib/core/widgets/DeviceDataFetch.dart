import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import 'package:kanga_care/core/util/const.dart';
import 'dart:convert' show json;

import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class DeviceDataFetch extends StatefulWidget {
  static Widget netWorkMessage = const Text('');
  int count = 0;
  static TextEditingController hostController =
      TextEditingController(text: Constants.deviceHost);
  static TextEditingController schemeController =
      TextEditingController(text: Constants.deviceSchema);
  static TextEditingController pathController =
      TextEditingController(text: Constants.devicePath);
  static int historicalDataMin = 0;
  static int historicalDataMax = 15;

  DeviceDataFetch({super.key});
  @override
  State<DeviceDataFetch> createState() => _DeviceDataFetchState();
}

class _DeviceDataFetchState extends State<DeviceDataFetch> {
  _DeviceDataFetchState() {
    timer =
        Timer.periodic(const Duration(milliseconds: 100), _updateDataSource);
  }
  Timer? timer;
  List<_ChartData> liveData = <_ChartData>[];
  List<_ChartData> historicalData = <_ChartData>[];
  ChartSeriesController? _liveDataSeriesController;
  ChartSeriesController? _historicalDataSeriesController;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<http.Response> _makeFetchReadingsFromDevice() async {
    var res;
    final client = http.Client();
    try {
      res = await client.get(
        Uri(
            scheme: DeviceDataFetch.schemeController.text,
            host: DeviceDataFetch.hostController.text,
            path: DeviceDataFetch.pathController.text),
        headers: {'content-type': 'application/json'},
      );
      // ignore: empty_catches
    } catch (e) {}
    client.close();
    return res;
  }

  void _updateDataSource(Timer timer) {
    debugPrint("================================>KIBANDE");
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
          DeviceDataFetch.historicalDataMax = historicalData.length - 1;
          DeviceDataFetch.historicalDataMin = 0;
        });
      } else {
        //for historical data
        _historicalDataSeriesController?.updateDataSource(
          addedDataIndexes: <int>[DeviceDataFetch.historicalDataMax],
          removedDataIndexes: <int>[DeviceDataFetch.historicalDataMin],
        );
      }
      setState(() {
        widget.count = widget.count + 1;

        DeviceDataFetch.netWorkMessage = const Text(
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
      setState(() {
        DeviceDataFetch.netWorkMessage = const Text(
          "Offline",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.red,
              fontSize: 16.0,
              fontFamily: CustomTextStyles.fontName),
        );
      });
    });
  }
}

class _ChartData {
  _ChartData(this.country, this.sales);
  final int country;
  final num sales;
}
