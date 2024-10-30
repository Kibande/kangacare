import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './home.dart';
import './Profile_And_Settings/profile.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  static const routeName = '/homeScreen';
  bool isConnectedToBle = false;
  BluetoothDevice device = BluetoothDevice.fromId("1234");
  Widget netWorkMessage = const Text(
    "Offline",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.red,
        fontSize: 16.0,
        fontFamily: CustomTextStyles.fontName),
  );
  Widget bluetoothMessage = const Text(
    "Disconnected",
    textAlign: TextAlign.center,
    style: TextStyle(
        color: Colors.red,
        fontSize: 16.0,
        fontFamily: CustomTextStyles.fontName),
  );
  Widget batteryLevel = const Text(
    "---",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16.0, fontFamily: CustomAppThemes.fontName),
  );

  Widget celsiusReading = const Text(
    "---",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 24.0, fontFamily: CustomTextStyles.fontName),
  );
  Widget fahrenheitReading = const Text(
    "---",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 24.0, fontFamily: CustomTextStyles.fontName),
  );

  Widget statusReading = const Text(
    "---",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 24.0, fontFamily: CustomTextStyles.fontName),
  );
  MainScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BluetoothCharacteristic? temperatureCharacteristic;
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  BluetoothConnectionState _connectionState =
      BluetoothConnectionState.disconnected;

  late StreamSubscription<BluetoothConnectionState>
      _connectionStateSubscription;
  late StreamSubscription<bool> _isConnectingSubscription;

  late StreamSubscription<bool> _isDisconnectingSubscription;

  late StreamSubscription<BluetoothAdapterState> _adapterStateStateSubscription;

  _MainScreenState() {
    timer = Timer.periodic(
        const Duration(milliseconds: 100), _refreshUserCredentials);
  }
  Timer? timer;
  Timer? _dataSendTimer;
  late PageController _pageController;
  int _page = 0;

  List icons = [
    Icons.home,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
    List pages = [
      Home(
        adapterState: _adapterState,
        linkDevice: linkDevice,
        device: widget.device,
        widget: widget,
      ),
      const Profile(),
    ];

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
    _adapterStateStateSubscription =
        FlutterBluePlus.adapterState.listen((state) {
      _adapterState = state;
      if (mounted) {
        setState(() {});
      }
    });
    _pageController = PageController();
    linkDevice();

    _dataSendTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      final appState = Provider.of<AppState>(context, listen: false);
      appState.sendAppStateData();
    });
  }

  @override
  void dispose() {
    _adapterStateStateSubscription.cancel();
    _pageController.dispose();
    _connectionStateSubscription.cancel();
    _isConnectingSubscription.cancel();
    _isDisconnectingSubscription.cancel();
    timer?.cancel();
    _dataSendTimer?.cancel();
    super.dispose();
  }

  bool get isConnected {
    return _connectionState == BluetoothConnectionState.connected;
  }

  void flatLineAllValues() {
    setState(() {
      widget.isConnectedToBle = false;
      widget.celsiusReading = const Text(
        '---',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24.0, fontFamily: CustomTextStyles.fontName),
      );

      widget.fahrenheitReading = const Text(
        '---',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24.0, fontFamily: CustomTextStyles.fontName),
      );

      widget.batteryLevel = const Text(
        '---',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16.0, fontFamily: CustomAppThemes.fontName),
      );

      widget.statusReading = const Text(
        "---",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.green,
            fontSize: 24.0,
            fontFamily: CustomTextStyles.fontName),
      );
    });
  }

  Widget getBluetoothMessgae() {
    if (_connectionState == BluetoothConnectionState.connected) {
      return const Text(
        'Connected',
        style: TextStyle(
            color: Colors.green,
            fontSize: 16.0,
            fontFamily: CustomTextStyles.fontName),
      );
    } else if (_connectionState == BluetoothConnectionState.disconnected) {
      return const Text(
        'Disconnected',
        style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
            fontFamily: CustomTextStyles.fontName),
      );
    } else {
      return const Text(
        'Connected', // the bluetooth adapter reads unknown between device characterstics reads
        style: TextStyle(
            color: Colors.green,
            fontSize: 16.0,
            fontFamily: CustomTextStyles.fontName),
      );
    }
  }

  Future<void> linkDevice() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? lastConnectedDeviceId = prefs.getString('lastConnectedDeviceId');

      if (lastConnectedDeviceId != null) {
        setState(() {
          widget.device = BluetoothDevice(
              remoteId: DeviceIdentifier(lastConnectedDeviceId));
        });

        // Connect to the device before discovering services
        await widget.device.connect();

        _connectionStateSubscription =
            widget.device.connectionState.listen((state) async {
          _connectionState = state;

          if (_connectionState == BluetoothConnectionState.connected) {
            discoverServices(widget.device);
          }

          setState(() {
            widget.bluetoothMessage = getBluetoothMessgae();
          });

          if (_connectionState == BluetoothConnectionState.disconnected) {
            flatLineAllValues();
          }
        });
      }
    } catch (e) {
      if (e is FlutterBluePlusException &&
          e.code == FbpErrorCode.connectionCanceled.index) {
        // ignore connections canceled by the user
      } else {
        print('Connect Error $e');
      }
    }
  }

  void discoverServices(BluetoothDevice device) async {
    List<BluetoothService> services = await device.discoverServices();
    for (BluetoothService service in services) {
      if (service.uuid.toString() == "4fafc201-1fb5-459e-8fcc-c5c9c331914b") {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.uuid.toString() ==
              "beb5483e-36e1-4688-b7f5-ea07361b26a8") {
            temperatureCharacteristic = characteristic;
            listenToTemperatureChanges();
            break;
          }
        }
      }
    }
  }

  void listenToTemperatureChanges() {
    temperatureCharacteristic?.setNotifyValue(true);
    temperatureCharacteristic?.lastValueStream.listen((value) {
      String data = String.fromCharCodes(value);

      String temp = data.split(';').first;
      String battery = data.split(';').last;
      setState(() {
        widget.isConnectedToBle = true;

        double float_temp = double.parse(temp);

        if (float_temp > 36.4 && float_temp < 37.4) {
          // normal
        }

        if (float_temp > 37.4 && float_temp < 38) {
          // warming

          // Vibrate.feedback(FeedbackType.warning);
        }

        if (float_temp > 38) {
          // danger
        }

        widget.celsiusReading = Text(
          '$temp°C',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.green,
              fontSize: 24.0,
              fontFamily: CustomTextStyles.fontName),
        );

        try {
          double franTemp = (float_temp * 9 / 5) + 32;
          String fixedFran = franTemp.toStringAsFixed(2);

          widget.fahrenheitReading = Text(
            '$fixedFran°F',
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontFamily: CustomTextStyles.fontName),
          );
          // ignore: empty_catches
        } catch (e) {}

        widget.bluetoothMessage = const Text(
          'Connected', // the bluetooth adapter reads unknown between device characterstics reads
          style: TextStyle(
              color: Colors.green,
              fontSize: 16.0,
              fontFamily: CustomTextStyles.fontName),
        );
        widget.batteryLevel = Text(
          '$battery%',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.green,
              fontSize: 16.0,
              fontFamily: CustomAppThemes.fontName),
        );

        widget.statusReading = const Text(
          "Normal",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.green,
              fontSize: 24.0,
              fontFamily: CustomTextStyles.fontName),
        );
      });
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
