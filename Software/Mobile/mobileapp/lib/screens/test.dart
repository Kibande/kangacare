// import 'package:flutter/material.dart';
// import 'package:kanga_care/core/app_state.dart';
// import 'package:kanga_care/core/styling/text_styles_and_colors.dart';
// import 'package:kanga_care/core/widgets/request_baby_details.dart';
// import 'package:intl/intl.dart';
// import 'package:kanga_care/screens/main_screen.dart';
// import 'package:kanga_care/utils/helper.dart';
// import 'package:provider/provider.dart';

// import 'dart:io';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:image_cropper/image_cropper.dart';

// class BabyProfile extends StatelessWidget {
//   const BabyProfile({
//     super.key,
//     required this.widget,
//     required this.context,
//   });

//   final MainScreen widget;
//   final BuildContext context;

//   Future<void> getImage(BuildContext context, ImageSource source) async {
//     final appState = Provider.of<AppState>(context, listen: false);

//     final ImagePicker picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: source);

//     if (image != null) {
//       CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: image.path,
//         compressFormat: ImageCompressFormat.jpg,
//         compressQuality: 50,
//         aspectRatioPresets: [
//           CropAspectRatioPreset.square,
//         ],
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: 'Cropper',
//             toolbarColor: Theme.of(context).colorScheme.primary,
//             toolbarWidgetColor: Colors.white,
//             lockAspectRatio: false,
//           ),
//           IOSUiSettings(
//             title: 'Cropper',
//           ),
//           WebUiSettings(
//             context: context,
//           ),
//         ],
//       );

//       if (croppedFile != null) {
//         // Get the app's document directory
//         final Directory appDir = await getApplicationDocumentsDirectory();
//         final String filePath = '${appDir.path}/baby_profile.png';

//         // Save the image to the app's document directory
//         final File newImage = await File(croppedFile.path).copy(filePath);

//         if (newImage.existsSync()) {
//           appState.setBabyPicUrl(image_url: filePath);
//         }
//       }
//     }

//     Navigator.of(context).pop(); // pop the choose image dialog
//   }

//   Future<void> uploadImage() async {
//     await openImagePicker(context);
//   }

//   openImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           height: Helper.getScreenHeight(context) * .15,
//           padding: const EdgeInsets.all(10),
//           child: Column(
//             children: <Widget>[
//               const Text('Get baby profile picture'),
//               const SizedBox(height: 10),
//               Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text('Use Camera'),
//                       onPressed: () {
//                         getImage(context, ImageSource.camera);
//                       },
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       child: const Text('Use Gallery'),
//                       onPressed: () {
//                         getImage(context, ImageSource.gallery);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<AppState>(
//       builder: (context, appState, child) {
//         TextEditingController datePickerController = TextEditingController();

//         selectBirthDate({required BuildContext context}) async {
//           DateTime? pickedDate = await showDatePicker(
//             context: context,
//             lastDate: DateTime.now(),
//             firstDate: DateTime(2015),
//             initialDate: DateTime.now(),
//           );
//           if (pickedDate == null) return;
//           datePickerController.text =
//               DateFormat('yyyy-MM-dd').format(pickedDate);
//         }

//         return ListView(
//           children: [
//             Center(
//               child: SizedBox(
//                 height: Helper.getScreenHeight(context),
//                 width: Helper.getScreenWidth(context),
//                 child: Column(
//                   children: [
//                     Container(
//                       color: Theme.of(context).colorScheme.tertiary,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(10.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     appState.getBabyName,
//                                     style:
//                                         Helper.getTheme(context).headlineMedium,
//                                   ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       requestBabyDetails(context: context);
//                                       appState.setBabyID(id: "WE567");
//                                     },
//                                     child: const Text("Edit"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Stack(
//                                   alignment: AlignmentDirectional.topEnd,
//                                   children: <Widget>[
//                                     ClipOval(
//                                       child: CircleAvatar(
//                                         radius: Helper.getScreenWidth(context) *
//                                             .12,
//                                         child: appState.getBabyPicUrl
//                                                 .contains("assets/images")
//                                             ? Image.asset(
//                                                 appState.getBabyPicUrl)
//                                             : Image.file(
//                                                 File(appState.getBabyPicUrl)),
//                                       ),
//                                     ),
//                                     GestureDetector(
//                                       child: Container(
//                                         width: 30,
//                                         height: 30,
//                                         decoration: BoxDecoration(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .primary,
//                                           borderRadius: const BorderRadius.all(
//                                             Radius.circular(50.0),
//                                           ),
//                                         ),
//                                         child: const Icon(Icons.add),
//                                       ),
//                                       onTap: () => uploadImage(),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'Birth Weight: ',
//                                           style: Helper.getTheme(context)
//                                               .headlineSmall,
//                                         ),
//                                         Text(
//                                             '${appState.getBabyBirthWeight}grms'),
//                                       ],
//                                     ),
//                                     Row(
//                                       children: [
//                                         Center(
//                                           child: Text(
//                                             'Current Read: ',
//                                             style: Helper.getTheme(context)
//                                                 .headlineSmall,
//                                           ),
//                                         ),
//                                         widget.celsiusReading,
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: Helper.getScreenHeight(context) * 0.01,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           'Date of Birth: ',
//                                           style: Helper.getTheme(context)
//                                               .headlineSmall,
//                                         ),
//                                       ),
//                                       Text(appState.getBabyDOB),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           'Time of Birth: ',
//                                           style: Helper.getTheme(context)
//                                               .headlineSmall,
//                                         ),
//                                       ),
//                                       Text(appState.getBabyTOB),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: Helper.getScreenHeight(context) * 0.01,
//                     ),
//                     Center(
//                       child: Text(
//                         'Contact Information',
//                         style: Helper.getTheme(context).headlineMedium,
//                       ),
//                     ),
//                     SizedBox(
//                       height: Helper.getScreenHeight(context) * 0.01,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(appState.getParent1Name),
//                             Text(appState.getParent1Contact),
//                           ],
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(appState.getParent2Name),
//                             Text(appState.getParent2Contact),
//                           ],
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: Helper.getScreenHeight(context) * 0.02,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Historical Data',
//                             style: Helper.getTheme(context).headlineSmall,
//                           ),
//                           SizedBox(
//                             height: Helper.getScreenHeight(context) * .05,
//                             width: Helper.getScreenWidth(context) * .5,
//                             child: TextFormField(
//                               obscureText: false,
//                               controller: datePickerController,
//                               readOnly: true,
//                               decoration: InputDecoration(
//                                 labelText: 'Date',
//                                 hintText: 'click to select',
//                                 labelStyle: const TextStyle(
//                                     color: CustomColors.GreyText),
//                                 hintStyle: const TextStyle(
//                                     color: CustomColors.GreyTextLightExtra),
//                                 enabledBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .surface),
//                                 ),
//                                 focusedBorder: UnderlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Theme.of(context)
//                                           .colorScheme
//                                           .surface),
//                                 ),
//                               ),
//                               onTap: () => selectBirthDate(context: context),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(appState.getBabyID),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
