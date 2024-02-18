// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class AlzheimarDetectionController extends GetxController {
//   static AlzheimarDetectionController get instance => Get.find();
//   var selectedImagePath = ''.obs;
//   var selectedImageSize = ''.obs;
//
//   void getImage(ImageSource imageSource) async {
//     final pickedFile = await ImagePicker().pickImage(source: imageSource);
//     if (pickedFile != null) {
//       selectedImagePath.value = pickedFile.path;
//       selectedImageSize.value =
//       "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}Mb";
//
//       Get.snackbar(
//         "Success",
//         "Image Selected",
//         backgroundColor: Colors.green,
//         snackPosition: SnackPosition.BOTTOM, // Change position to top
//         duration: const Duration(seconds: 3),
//         margin: const EdgeInsets.all(10),
//         borderRadius: 10,
//         mainButton: TextButton(
//           onPressed: () {
//             // Retry logic goes here
//             Get.back(); // Dismiss the current snackbar
//             getImage(imageSource); // Retry the image selection
//           },
//           child: const Text(
//             'Retry',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );
//     } else {
//       Get.snackbar(
//         "Error",
//         "No Image Selected",
//         backgroundColor: Colors.red,
//         snackPosition: SnackPosition.BOTTOM, // Change position to top
//         duration: const Duration(seconds: 3),
//         margin: const EdgeInsets.all(10),
//         borderRadius: 10,
//         mainButton: TextButton(
//           onPressed: () {
//             // Retry logic goes here
//             Get.back(); // Dismiss the current snackbar
//             getImage(imageSource); // Retry the image selection
//           },
//           child: const Text(
//             'Retry',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       );
//       selectedImagePath.value = "";
//     }
//   }
// }
