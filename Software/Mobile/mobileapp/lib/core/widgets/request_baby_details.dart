import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:provider/provider.dart';

import '../styling/text_styles_and_colors.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class BabyDetailsWidget extends StatefulWidget {
  BabyDetailsWidget({
    Key? key,
  }) : super(key: key);

  bool fetchState = true;

  @override
  State<BabyDetailsWidget> createState() => _BabyDetailsWidgetState();
}

class _BabyDetailsWidgetState extends State<BabyDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);

    TextEditingController timePickerController =
        TextEditingController(text: appState.getBabyTOB);
    TextEditingController babyDatePickerController =
        TextEditingController(text: appState.getBabyDOB);
    TextEditingController babyNameController =
        TextEditingController(text: appState.getBabyName);

    TextEditingController babyBirthWeightController =
        TextEditingController(text: appState.getBabyBirthWeight);

    TextEditingController parent1NameController =
        TextEditingController(text: appState.getParent1Name);
    TextEditingController parent1ContactController =
        TextEditingController(text: appState.getParent1Contact);
    TextEditingController parent2NameController =
        TextEditingController(text: appState.getParent2Name);
    TextEditingController parent2ContactController =
        TextEditingController(text: appState.getParent2Contact);

    selectBirthDate({required BuildContext context}) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime.now(),
        firstDate: DateTime(2015),
        initialDate: DateTime.now(),
      );
      if (pickedDate == null) return;
      babyDatePickerController.text =
          DateFormat('yyyy-MM-dd').format(pickedDate);
    }

    selectBirthTime({required BuildContext context}) async {
      TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (pickedTime == null) return;

      timePickerController.text = pickedTime.format(context);
    }

    return SizedBox(
      width: double.infinity,
      child: Material(
        clipBehavior: Clip.antiAlias,
        elevation: 2.0,
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ListTile(
                title: Text('Baby Details',
                    style: Helper.getTheme(context).headlineMedium),
                trailing: Text(
                  'ID: ${appState.getBabyID}',
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Theme.of(context).textTheme.headlineSmall?.color
                        : Theme.of(context).primaryColor,
                  ),
                ),
              ),
              TextFormField(
                controller: babyNameController,
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Baby Name',
                  hintText: 'name',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
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
                controller: babyDatePickerController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Birth Date',
                  hintText: 'click here to select a date',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
                onTap: () => selectBirthDate(context: context),
              ),
              TextFormField(
                obscureText: false,
                keyboardType: TextInputType.datetime,
                controller: timePickerController,
                decoration: const InputDecoration(
                  labelText: 'Birth Time',
                  hintText: 'click here to select a time',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
                onTap: () => selectBirthTime(context: context),
              ),
              TextFormField(
                controller: babyBirthWeightController,
                obscureText: false,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: false),
                decoration: const InputDecoration(
                  labelText: 'Birth Weight',
                  hintText: 'input weight in grams',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              TextFormField(
                controller: parent1NameController,
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Parent 1',
                  hintText: 'name',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              TextFormField(
                controller: parent1ContactController,
                obscureText: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Contact',
                  hintText: 'Input parents phone number',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              TextFormField(
                controller: parent2NameController,
                obscureText: false,
                decoration: const InputDecoration(
                  labelText: 'Parent 2',
                  hintText: 'name',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              TextFormField(
                controller: parent2ContactController,
                obscureText: false,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Contact',
                  hintText: 'Input parents phone number',
                  labelStyle: TextStyle(color: CustomColors.GreyText),
                  hintStyle: TextStyle(color: CustomColors.GreyTextLightExtra),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: CustomColors.GreyTextLight),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            appState.setBabyName(name: babyNameController.text);
                            appState.setBabyDOB(
                                dOB: babyDatePickerController.text);
                            appState.setBabyTOB(tOB: timePickerController.text);
                            appState.setBabyBirthWeight(
                                babyBirthWeight:
                                    babyBirthWeightController.text);

                            appState.setParent1Name(
                                name: parent1NameController.text);

                            appState.setParent1Contact(
                                contact: parent1ContactController.text);

                            appState.setParent2Name(
                                name: parent2NameController.text);

                            appState.setParent2Contact(
                                contact: parent2ContactController.text);

                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: CustomAppThemes.nearlyWhite,
                            ),
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

requestBabyDetails({required BuildContext context, bool firstPop = false}) {
  if (firstPop) {
    Navigator.of(context).pop();
  }

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: BabyDetailsWidget(),
      ),
    ),
  );
}
