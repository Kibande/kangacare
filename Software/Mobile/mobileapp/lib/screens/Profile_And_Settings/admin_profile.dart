import 'dart:math';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kanga_care/core/util/const.dart';
import 'package:kanga_care/screens/Profile_And_Settings/components/admin_account_info_widget.dart';
import 'package:kanga_care/utils/helper.dart';
import 'package:share/share.dart';

import '../../features/user_authentication/presentation/pages/landingScreen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../core/app_state.dart';

import 'components/account_page_list_item.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  List<Widget> listViews = <Widget>[];
  final ScrollController scrollController = ScrollController();
  Future logout() async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.resetAppStates();
    Navigator.of(context).pushNamedAndRemoveUntil(
        LandingScreen.routeName, (Route<dynamic> route) => false);
  }

  Future resetApp() async {
    final appState = Provider.of<AppState>(context, listen: false);
    appState.resetAppStates();
    Navigator.of(context).pushNamedAndRemoveUntil(
        LandingScreen.routeName, (Route<dynamic> route) => false);
  }

  Future<void> getImage(BuildContext context, ImageSource source) async {
    final appState = Provider.of<AppState>(context, listen: false);

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 50,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
          ),
        ],
      );

      if (croppedFile != null) {
        // Get the app's document directory
        final Directory appDir = await getApplicationDocumentsDirectory();
        String randomFileName =
            'baby_profile_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}.png';
        final String filePath = '${appDir.path}/$randomFileName';

        // Save the image to the app's document directory
        final File newImage = await File(croppedFile.path).copy(filePath);

        if (newImage.existsSync()) {
          appState.setAdminPicUrl(image_url: filePath);
        }
      }
    }

    Navigator.of(context).pop(); // pop the choose image dialog
  }

  Future<void> uploadImage() async {
    await openImagePicker(context);
  }

  openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: Helper.getScreenHeight(context) * .15,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                const Text(
                  'Get yourself a profile picture',
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: const Text(
                          'Use Camera',
                        ),
                        onPressed: () {
                          getImage(context, ImageSource.camera);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text(
                          'Use Gallery',
                        ),
                        onPressed: () {
                          getImage(context, ImageSource.gallery);
                        },
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

  addAllListData(BuildContext context) {
    // final appState = Provider.of<AppState>(context);
    final List<AccountPageListItem> settingsitems = [
      AccountPageListItem(
          title: "Help",
          icon: const Icon(
            Icons.info,
            color: Colors.blue,
          ),
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Container(
                            height: Helper.getScreenHeight(context) * 0.55,
                            width: Helper.getScreenWidth(context) * 0.9,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Column(children: [
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Help Info",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.color,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontSize,
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontWeight,
                                    ),
                                  ),
                                )),
                                const Divider(
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                        '''Connect the application to the Kanga Care devices bluetooth network.\n\nThis will enable the mobile application read values from the device.\n\nIncase this fails seek technical help.
                                        ''',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          wordSpacing: 3,
                                        )),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ))
              }),
      AccountPageListItem(
          title: "Share App",
          icon: const Icon(
            Icons.share,
            color: Colors.purple,
          ),
          onPressed: () => {Share.share(Constants.googlePlayLink)}),
      AccountPageListItem(
          title: "Terms of Service",
          icon: const Icon(
            Icons.receipt,
            color: Colors.blueGrey,
          ),
          onPressed: () => {
                showDialog(
                    context: context,
                    builder: (context) => Center(
                          child: Container(
                            height: Helper.getScreenHeight(context) * 0.35,
                            width: Helper.getScreenWidth(context) * 0.9,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Column(children: [
                                Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Terms and Conditions",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.color,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontSize,
                                      fontWeight: Theme.of(context)
                                          .textTheme
                                          .headlineMedium
                                          ?.fontWeight,
                                    ),
                                  ),
                                )),
                                const Divider(
                                  height: 10,
                                  color: Colors.grey,
                                ),
                                Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                        '''This is a protoype application, meant to be used under technical supervision.\n\nProperty of Buri Care
                                        ''',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.color,
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          wordSpacing: 3,
                                        )),
                                  ),
                                )
                              ]),
                            ),
                          ),
                        ))
              }),
      AccountPageListItem(
          title: "Reset App",
          icon: const Icon(
            Icons.clear,
            color: Colors.lime,
          ),
          onPressed: resetApp),
      AccountPageListItem(
          title: "Logout",
          icon: const Icon(
            Icons.power_settings_new,
            color: Colors.red,
          ),
          onPressed: logout),
    ];

    for (var i = 0; i < settingsitems.length; i++) {
      listViews.add(settingsitems[i]);
    }
  }

  @override
  void initState() {
    addAllListData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AdminAccountInfoWidget(uploadImage: uploadImage),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.58,
          child: ListView.builder(
            controller: scrollController,
            padding: const EdgeInsets.only(
              top: 0,
            ),
            itemCount: listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return listViews[index];
            },
          ),
        )
      ],
    );
  }
}
