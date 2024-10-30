import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import 'package:kanga_care/core/widgets/bluetoothDialog.dart';
import 'package:kanga_care/screens/main_screen.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:provider/provider.dart';

class BabyReader extends StatelessWidget {
  const BabyReader({
    super.key,
    required this.widget,
    required this.context,
    required this.adapterState,
    required this.linkDevice,
  });

  final MainScreen widget;

  final BuildContext context;
  final Future<void> Function() linkDevice;
  final BluetoothAdapterState? adapterState;
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    appState.findLastConnectedDeviceName();
    return Column(
      children: [
        SizedBox(
          height: Helper.getScreenHeight(context) * 0.04,
          width: Helper.getScreenWidth(context),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              // height: Helper.getScreenHeight(context) * 0.04,
              width: Helper.getScreenWidth(context) * 0.8,
              child: Center(
                  child: Text(
                widget.isConnectedToBle
                    ? appState.getLastConnectedDeviceName
                    : "",
                style: Helper.getTheme(context).headlineSmall,
              )),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                          child: Text(
                        'Internet: ',
                        style: Helper.getTheme(context).headlineSmall,
                      )),
                      widget.netWorkMessage,
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                          child: Text(
                        'Bluetooth: ',
                        style: Helper.getTheme(context).headlineSmall,
                      )),
                      widget.bluetoothMessage
                    ],
                  ),
                  Row(
                    children: [
                      Center(
                          child: Text(
                        'Battery Level: ',
                        style: Helper.getTheme(context).headlineSmall,
                      )),
                      widget.batteryLevel,
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () => {
                        showBluetoothDialog(
                            context: context, linkDevice: linkDevice)
                      },
                  style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  icon: Icon(
                    widget.isConnectedToBle
                        ? Icons.bluetooth_connected
                        : Icons.bluetooth_disabled,
                    // color: Theme.of(context).colorScheme.primary,
                  )),
            )
          ],
        ),
        SizedBox(
          height: Helper.getScreenHeight(context) * 0.01,
        ),
        SizedBox(
          height: Helper.getScreenHeight(context) * 0.6,
          child: Column(
            children: [
              SizedBox(
                height: Helper.getScreenHeight(context) * 0.01,
              ),
              Container(
                alignment: Alignment.center,
                child: widget.isConnectedToBle
                    ? AvatarGlow(
                        glowColor: widget.isConnectedToBle
                            ? Colors.green
                            : Colors.grey,
                        endRadius: Helper.getScreenWidth(context) *
                            .30, // Adjust radius as needed
                        duration: const Duration(milliseconds: 2000),
                        repeat: true,
                        showTwoGlows: true,
                        child: CircleAvatar(
                          radius: Helper.getScreenWidth(context) * .25,
                          backgroundColor: widget.isConnectedToBle
                              ? Colors.green
                              : Colors.grey,
                          child: ClipOval(
                            child: CircleAvatar(
                              radius: Helper.getScreenWidth(context) * .20,
                              child: Image.asset(
                                Helper.getAssetName("Default.png", "virtual"),
                              ),
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: Helper.getScreenWidth(context) * .30,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        child: CircleAvatar(
                          radius: Helper.getScreenWidth(context) * .25,
                          backgroundColor: widget.isConnectedToBle
                              ? Colors.green
                              : Colors.grey,
                          child: ClipOval(
                            child: CircleAvatar(
                              radius: Helper.getScreenWidth(context) * .20,
                              child: Image.asset(
                                Helper.getAssetName("Default.png", "virtual"),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: Helper.getScreenHeight(context) * 0.03,
              ),
              Center(
                child: Text(
                  'Reading',
                  style: Helper.getTheme(context).headlineMedium,
                ),
              ),
              SizedBox(
                height: Helper.getScreenHeight(context) * 0.01,
              ),
              SizedBox(
                height: Helper.getScreenHeight(context) * 0.12,
                width: Helper.getScreenWidth(context),
                child: Row(
                  children: [
                    SizedBox(
                      width: Helper.getScreenWidth(context) * 0.5,
                      height: Helper.getScreenHeight(context) * 0.12,
                      child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thermostat,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      Text(
                                        "Celsius",
                                        style: Helper.getTheme(context)
                                            .headlineSmall,
                                      )
                                    ],
                                  ),
                                  widget.celsiusReading
                                ],
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      width: Helper.getScreenWidth(context) * 0.5,
                      height: Helper.getScreenHeight(context) * 0.12,
                      child: Container(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.tertiary,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.thermostat,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                      Text(
                                        "Fahrenheit",
                                        style: Helper.getTheme(context)
                                            .headlineSmall,
                                      )
                                    ],
                                  ),
                                  widget.fahrenheitReading
                                ],
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Helper.getScreenHeight(context) * .053,
                child: Center(
                  child: widget.statusReading,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
