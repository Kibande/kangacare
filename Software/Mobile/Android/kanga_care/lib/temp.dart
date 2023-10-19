// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'ESP32 Data Monitor',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HomeScreen(),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final List<Tab> tabs = [
//     Tab(text: 'Graph'),
//     Tab(text: 'Value'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: tabs.length,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('ESP32 Data Monitor'),
//           bottom: TabBar(
//             tabs: tabs,
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             GraphTab(),
//             ValueTab(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class GraphTab extends StatelessWidget {
//   final List<charts.Series> seriesList = [
//     charts.Series(
//       id: 'Data',
//       domainFn: (DataPoint data, _) => data.time,
//       measureFn: (DataPoint data, _) => data.value,
//       data: [
//         DataPoint(DateTime(2023, 5, 1, 12, 0), 10),
//         DataPoint(DateTime(2023, 5, 1, 12, 5), 15),
//         DataPoint(DateTime(2023, 5, 1, 12, 10), 12),
//         // Add more data points as they come in
//       ],
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16.0),
//       child: charts.TimeSeriesChart(
//         seriesList,
//         animate: true,
//         domainAxis: charts.DateTimeAxisSpec(
//           tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
//             day: charts.TimeFormatterSpec(
//               format: 'HH:mm',
//               transitionFormat: 'HH:mm',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ValueTab extends StatelessWidget {
//   final int currentValue = 20; // Replace with the value from ESP32

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: CircleAvatar(
//         radius: 100,
//         backgroundColor: Colors.blue,
//         child: Text(
//           '$currentValue',
//           style: TextStyle(
//             fontSize: 48,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DataPoint {
//   final DateTime time;
//   final double value;

//   DataPoint(this.time, this.value);
// }
