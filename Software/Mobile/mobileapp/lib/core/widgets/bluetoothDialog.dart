import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomBluetoothDialog extends StatefulWidget {
  CustomBluetoothDialog({Key? key, required this.linkDevice}) : super(key: key);
  final Future<void> Function() linkDevice;
  String? lastConnectedDeviceName;

  @override
  State<CustomBluetoothDialog> createState() => _CustomBluetoothDialogState();
}

class _CustomBluetoothDialogState extends State<CustomBluetoothDialog> {
  bool isBluetoothOn = false;
  List<BluetoothDevice> _systemDevices = [];
  List<ScanResult> _scanResults = [];
  bool _isScanning = false;
  BluetoothDevice? connectedDevice;
  String? lastConnectedDeviceId;

  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  late StreamSubscription<bool> _isScanningSubscription;

  @override
  void initState() {
    super.initState();
    _loadBluetoothState();
    checkBluetoothStatus();

    _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
      _scanResults = results
          .where((r) =>
              r.device.advName.startsWith("BuriCare") &&
              r.device.remoteId != connectedDevice?.remoteId)
          // .where((r) => r.device.remoteId != connectedDevice?.remoteId)
          .toList();

      setState(() {});
    });

    _isScanningSubscription = FlutterBluePlus.isScanning.listen((state) {
      _isScanning = state;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _scanResultsSubscription.cancel();
    _isScanningSubscription.cancel();
    super.dispose();
  }

  Future<void> _loadBluetoothState() async {
    final prefs = await SharedPreferences.getInstance();
    lastConnectedDeviceId = prefs.getString('lastConnectedDeviceId');
    widget.lastConnectedDeviceName = prefs.getString('lastConnectedDeviceName');

    setState(() {});
    _autoReconnect();
  }

  Future<void> _saveBluetoothState(String deviceId, String deviceName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastConnectedDeviceId', deviceId);
    await prefs.setString('lastConnectedDeviceName', deviceName);
    setState(() {
      widget.lastConnectedDeviceName = deviceName;
    });
    widget.linkDevice();
  }

  Future<void> _autoReconnect() async {
    if (lastConnectedDeviceId != null && connectedDevice == null) {
      BluetoothDevice device =
          BluetoothDevice(remoteId: DeviceIdentifier(lastConnectedDeviceId!));

      await connectToDevice(device);
    }
  }

  Future<void> checkBluetoothStatus() async {
    isBluetoothOn = await FlutterBluePlus.isOn;
    setState(() {});
  }

  Future<void> toggleBluetooth() async {
    if (isBluetoothOn) {
      await FlutterBluePlus.turnOff();
    } else {
      await FlutterBluePlus.turnOn();
      onScanPressed(); // Start scanning automatically when Bluetooth is turned on
    }
    checkBluetoothStatus();
  }

  Future<void> onScanPressed() async {
    _scanResults.clear();
    try {
      _systemDevices = await FlutterBluePlus.systemDevices;
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    } catch (e) {}
  }

  Future<void> onStopPressed() async {
    try {
      await FlutterBluePlus.stopScan();
    } catch (e) {}
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();

      setState(() {
        connectedDevice = device;
        _scanResults = _scanResults
            .where((r) => r.device.remoteId != connectedDevice?.remoteId)
            .toList();
      });

      String dvName = device.advName != ""
          ? device.advName
          : widget.lastConnectedDeviceName ??
              "ALL BLK"; // since the bluetooth objects loaded from the ID dont have names
      await _saveBluetoothState(device.remoteId.toString(), dvName);
    } catch (e) {}
  }

  Future<void> disconnectFromDevice() async {
    if (connectedDevice != null) {
      try {
        await connectedDevice!.disconnect();
        _saveBluetoothState("", "Unknown Device");
        onScanPressed();
        setState(() {
          connectedDevice = null;
        });
      } catch (e) {}
    }
  }

  List<Widget> _buildScanResultTiles(BuildContext context) {
    Provider.of<AppState>(context).forcedNotifyListeners();
    return _isScanning
        ? [const CircularProgressIndicator()]
        : _scanResults.isEmpty && connectedDevice == null
            ? [
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text("No Buricare devices found"),
                    ),
                  ),
                )
              ]
            : _scanResults
                .map(
                  (r) => ListTile(
                    title: Text(r.device.advName),
                    subtitle: Text(r.device.remoteId.toString()),
                    trailing: ElevatedButton(
                      onPressed: () => connectToDevice(r.device),
                      child: const Text("Connect"),
                    ),
                  ),
                )
                .toList();
  }

  Widget buildScanButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: _isScanning ? onStopPressed : onScanPressed,
          child: Text(
            _isScanning ? "Stop" : "Scan",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: () => {Navigator.pop(context)},
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            foregroundColor:
                WidgetStateProperty.all(Theme.of(context).colorScheme.primary),
            shape: WidgetStateProperty.all(
              StadiumBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          child: Text(
            "Close",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }

  Widget buildConnectedDeviceInfo(BuildContext context) {
    Provider.of<AppState>(context).forcedNotifyListeners(); // manualy hack
    return connectedDevice != null
        ? Column(
            children: [
              ListTile(
                title: Text(widget.lastConnectedDeviceName ?? "NOT DE"),
                trailing: ElevatedButton(
                  onPressed: disconnectFromDevice,
                  child: const Text("Disconnect"),
                ),
              ),
            ],
          )
        : const SizedBox();
  }

  Widget buildToggleSwitch() {
    return ListTile(
      title: const Text('Bluetooth'),
      trailing: Switch(
        value: isBluetoothOn,
        onChanged: (newValue) {
          toggleBluetooth();
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const ListTile(
                title: Center(
                  child: Text(
                    "Bluetooth Connections",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              buildToggleSwitch(),
              buildConnectedDeviceInfo(context),
              ..._buildScanResultTiles(context),
              buildScanButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

void showBluetoothDialog(
    {required BuildContext context,
    required Future<void> Function() linkDevice}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomBluetoothDialog(
              linkDevice: linkDevice,
            ),
          ],
        ),
      ),
    ),
  );
}
