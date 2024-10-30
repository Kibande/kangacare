import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kanga_care/core/app_state.dart';
import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:provider/provider.dart';

class BabyCard extends StatelessWidget {
  const BabyCard({
    super.key,
    required this.babyName,
    required this.babyTemp,
    required this.babyState,
    required this.babyPicUrl,
    required this.babyBirthWeight,
    required this.babyBirthTime,
    required this.babyBirthDate,
    required this.babyContactName1,
    required this.babyContactTel1,
    required this.babyContactName2,
    required this.babyContactTel2,
  });

  final String babyName;
  final String babyTemp;
  final String babyState;
  final String babyPicUrl;
  final String babyBirthWeight;
  final String babyBirthTime;
  final String babyBirthDate;
  final String babyContactName1;
  final String babyContactTel1;
  final String babyContactName2;
  final String babyContactTel2;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.blue,
        width: Helper.getScreenWidth(context) * 0.95,
        height: Helper.getScreenHeight(context) * 0.27,
        child: Container(
          color: Theme.of(context).colorScheme.tertiary,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        babyName,
                        style: Helper.getTheme(context).headlineMedium,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: <Widget>[
                        ClipOval(
                          child: CircleAvatar(
                            radius: Helper.getScreenWidth(context) * .12,
                            child: babyPicUrl.contains("assets/images")
                                ? Image.asset(babyPicUrl)
                                : Image.file(File(babyPicUrl)),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.thermostat,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            Text(
                              babyTemp,
                              style: Helper.getTheme(context).headlineSmall,
                            )
                          ],
                        ),
                        SizedBox(
                          width: Helper.getScreenWidth(context) * .26,
                          child: Center(
                            child: Text(
                              babyState,
                              style: Helper.getTheme(context).headlineSmall,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Center(
                                      child: Container(
                                        height:
                                            Helper.getScreenHeight(context) *
                                                0.4,
                                        width: Helper.getScreenWidth(context) *
                                            0.8,
                                        margin: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Center(
                                          child: Column(children: [
                                            Center(
                                                child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Baby Details",
                                                style: Helper.getTheme(context)
                                                    .headlineMedium,
                                              ),
                                            )),
                                            const Divider(
                                              height: 10,
                                              // color: Colors.grey,
                                            ),
                                            Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Name : ',
                                                          style: Helper
                                                                  .getTheme(
                                                                      context)
                                                              .headlineSmall,
                                                        ),
                                                        Text('${babyName}'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Birth Weight: ',
                                                          style: Helper
                                                                  .getTheme(
                                                                      context)
                                                              .headlineSmall,
                                                        ),
                                                        Text(
                                                            '${babyBirthWeight}grms'),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                          'Current Read: ',
                                                          style: Helper
                                                                  .getTheme(
                                                                      context)
                                                              .headlineSmall,
                                                        )),
                                                        Text(
                                                          babyTemp,
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                          'Date of Birth: ',
                                                          style: Helper
                                                                  .getTheme(
                                                                      context)
                                                              .headlineSmall,
                                                        )),
                                                        Text(babyBirthDate),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Center(
                                                            child: Text(
                                                          'Time of Birth: ',
                                                          style: Helper
                                                                  .getTheme(
                                                                      context)
                                                              .headlineSmall,
                                                        )),
                                                        Text(babyBirthTime),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: Helper
                                                              .getScreenHeight(
                                                                  context) *
                                                          0.01,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'Contact Information',
                                                        style: Helper.getTheme(
                                                                context)
                                                            .headlineMedium,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Helper
                                                              .getScreenHeight(
                                                                  context) *
                                                          0.01,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                babyContactName1),
                                                            Text(
                                                                babyContactTel1),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                babyContactName2),
                                                            Text(
                                                                babyContactTel2),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ]),
                                        ),
                                      ),
                                    ));
                          },
                          child: const Text(
                            "Details..",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.lightBlue,
                                color: Colors.lightBlue),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
