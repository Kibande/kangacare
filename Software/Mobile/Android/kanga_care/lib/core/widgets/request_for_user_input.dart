import 'package:open_settings/open_settings.dart';

import '../styling/text_styles_and_colors.dart';
import '../widgets/profile_tile_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class RequestAccountPasscodeWidget extends StatefulWidget {
  final TextEditingController schemeController;
  final Function()? processFunction;
  final Function(bool value)? liveFetchFunc;
  final TextEditingController hostController;
  final TextEditingController pathController;
  final bool fetchData;
  RequestAccountPasscodeWidget({
    Key? key,
    required this.schemeController,
    required this.processFunction,
    required this.liveFetchFunc,
    required this.hostController,
    required this.pathController,
    required this.fetchData,
  }) : super(key: key);

  bool fetchState = true;

  @override
  State<RequestAccountPasscodeWidget> createState() =>
      _RequestAccountPasscodeWidgetState();
}

class _RequestAccountPasscodeWidgetState
    extends State<RequestAccountPasscodeWidget> {
  @override
  Widget build(BuildContext context) {
    void openWiFiSettings() async {
      try {
        OpenSettings.openWIFISetting();
      } on PlatformException catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.message ?? 'Operation failed.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }

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
              ProfileTile(
                  title: "LAN Connection Details",
                  textColor: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).textTheme.headline1?.color
                      : Theme.of(context).primaryColor,
                  subtitle: "For Admin use only"),
              TextFormField(
                obscureText: false,
                controller: widget.schemeController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                decoration: const InputDecoration(
                  labelText: 'Scheme',
                  hintText: 'http/https',
                  labelStyle: TextStyle(color: CustomColors.GreyTextLight),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              TextFormField(
                obscureText: false,
                controller: widget.hostController,
                decoration: const InputDecoration(
                  labelText: 'Host',
                  hintText: '000.000.0.0',
                  labelStyle: TextStyle(color: CustomColors.GreyTextLight),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              TextFormField(
                obscureText: false,
                controller: widget.pathController,
                decoration: const InputDecoration(
                  labelText: 'Path',
                  hintText: 'DR',
                  labelStyle: TextStyle(color: CustomColors.GreyTextLight),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Live Fetch Data',
                ),
                trailing: Switch(
                    value: widget.fetchState,
                    onChanged: (newValue) {
                      setState(() {
                        widget.fetchState = newValue;
                        widget.liveFetchFunc!(newValue);
                      });
                    }),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                        onPressed: widget.processFunction,
                        child: const Text(
                          "Disk Save",
                          style: TextStyle(
                            color: CustomAppThemes.nearlyWhite,
                          ),
                        )),
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: openWiFiSettings,
                        child: const Text(
                          "Open Wi-Fi",
                          style: TextStyle(
                            color: CustomAppThemes.nearlyWhite,
                          ),
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

requestUserPasscode(
    {required TextEditingController schemeController,
    required TextEditingController hostController,
    required TextEditingController pathController,
    required Function()? processFunction,
    required Function(bool value)? liveFetchFunc,
    required bool fetchData,
    required BuildContext context,
    bool firstPop = false}) {
  if (firstPop) {
    Navigator.of(context).pop();
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RequestAccountPasscodeWidget(
              schemeController: schemeController,
              processFunction: processFunction,
              liveFetchFunc: liveFetchFunc,
              hostController: hostController,
              pathController: pathController,
              fetchData: fetchData,
            )
          ],
        ),
      ),
    ),
  );
}
