import 'dart:io';
import 'package:alzaware/core/utils/constants/image_strings.dart';
import 'package:alzaware/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/constants/text_strings.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../main.dart';
import '../app_wide_widgets/custom_appbar.dart';
import 'dart:async';
import 'dart:math';
import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AlzheimerDetection extends StatelessWidget {
  const AlzheimerDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    final AlzheimarDetectionController controller =
        Get.put(AlzheimarDetectionController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          showBackArrow: false,
          title: TTexts.alzheimerDetection,
        ),
      ),
      body: Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.selectedImages.isEmpty
                  ? const SizedBox(height: 20)
                  : const SizedBox(height: 0),
              controller.selectedImages.isEmpty
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.spaceBtwItems),
                      child: Text(TTexts.detectHomeHeadLine,
                          style: Theme.of(context).textTheme.bodyLarge!),
                    )
                  : const Text(""),
              const SizedBox(height: TSizes.spaceBtwItems),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      onPressed: () async {
                        controller.getImage(ImageSource.gallery);
                      },
                      child: Column(
                        children: [
                          Image(
                              height: 120,
                              image: AssetImage(dark
                                  ? TImages.uploadImageLight
                                  : TImages.uploadImageDark)),
                          Text(TTexts.uploadImage),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: OutlinedButton(
                      onPressed: () async {
                        controller.getImage(ImageSource.camera);
                      },
                      child: Column(
                        children: [
                          Image(
                              height: 120,
                              image: AssetImage(dark
                                  ? TImages.takephoto
                                  : TImages.takephoto)),
                          Text(TTexts.takePhoto),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.selectedImages.length,
                  itemExtent: 85,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var imagePair = controller.selectedImages[index];
                    var image = File(imagePair.imagePath);
                    var dateTime = imagePair.dateTime;
                    var formattedDateTime =
                        DateFormat('E-dd-MM-yyyy\nhh:mm a').format(dateTime);
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: FileImage(image),
                          ),
                          title: Text('${TTexts.mRI} ${index + 1}'),
                          subtitle: Text(formattedDateTime),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_red_eye),
                                onPressed: () {
                                  controller.viewImage(index, controller);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  controller.removeImage(index);
                                },
                              ),
                            ],
                          ),
                        ),
                        if (index != controller.selectedImages.length - 1)
                          const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class AlzheimarDetectionController extends GetxController {
  static AlzheimarDetectionController get instance => Get.find();
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  final List<String> diagnosis = [];
  RxList<ImageWithDateTime> selectedImages = <ImageWithDateTime>[].obs;
  final String _hiveBoxName = 'selectedImagesBox';

  @override
  void onInit() async {
    super.onInit();
    await _openHiveBox();
    await _loadSelectedImages();
  }

  Future<void> _openHiveBox() async {
    var appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox<ImageWithDateTime>(_hiveBoxName);
  }

  Future<void> _loadSelectedImages() async {
    var box = await Hive.openBox<ImageWithDateTime>(_hiveBoxName);
    selectedImages.assignAll(box.values.toList());
  }

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      var imageWithDateTime = ImageWithDateTime(
          pickedFile.path, DateTime.now(), "${_random.nextDouble() * 100}");
      selectedImages.add(imageWithDateTime);
      await _saveImage(imageWithDateTime);
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}Mb";

      Get.snackbar(
        TTexts.success,
        TTexts.imageSelected,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    } else {
      Get.snackbar(
        TTexts.error,
        TTexts.noImageSelected,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  Future<void> _saveImage(ImageWithDateTime image) async {
    var box = await Hive.openBox<ImageWithDateTime>(_hiveBoxName);
    await box.add(image);
  }

  Future<void> deleteData() async {
    var box = await Hive.openBox<ImageWithDateTime>(_hiveBoxName);
    box.clear();
  }

  void removeImage(int index) async {
    selectedImages.removeAt(index);
    await _removeImage(index);
    update();
  }

  Future<void> _removeImage(int index) async {
    var box = await Hive.openBox<ImageWithDateTime>(_hiveBoxName);
    await box.deleteAt(index);
  }

  void viewImage(int index, controller) {
    final imagePath = selectedImages[index].imagePath;
    Get.to(ViewImageScreen(
      imagePath: imagePath,
      controller: controller,
      index: index,
    ));
  }
}

class ImageWithDateTime {
  final String imagePath;
  final DateTime dateTime;
  String randomNum;

  ImageWithDateTime(this.imagePath, this.dateTime, this.randomNum);
}

class ImageWithDateTimeAdapter extends TypeAdapter<ImageWithDateTime> {
  @override
  final int typeId = 0; // يجب أن يكون مميزًا لنوع البيانات

  @override
  ImageWithDateTime read(BinaryReader reader) {
    return ImageWithDateTime(
      reader.readString(),
      DateTime.parse(reader.readString()),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, ImageWithDateTime obj) {
    writer.writeString(obj.imagePath);
    writer.writeString(obj.dateTime.toIso8601String());
    writer.writeString(obj.randomNum); // كتابة الرقم العشوائي
  }
}

// تعريف المتغير العشوائي لنسبة المرض
final Random _random = Random();

// دالة توليد نتيجة عشوائية لنسبة المرض
String _generateRandomPercentage(controller, index) {
  return controller.selectedImages[index].randomNum;
}

class ViewImageScreen extends StatelessWidget {
  final String imagePath;
  final AlzheimarDetectionController controller;
  final int index;

  const ViewImageScreen(
      {Key? key,
      required this.imagePath,
      required this.controller,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(showBackArrow: true, title: TTexts.viewAndDetect),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: TSizes.spaceBtwItems),
            Image.file(File(imagePath), width: double.maxFinite, height: 300),
            const SizedBox(height: TSizes.spaceBtwItems),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await _detectAlzheimers(context, index);
                  },
                  child: Text(TTexts.detectAlzheimer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to show the loading screen
  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Text(TTexts.detectingAlzheimer),
              ],
            ),
          ),
        );
      },
    );
  }

  // Method to show the result dialog
  void showResultDialog(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            TTexts.alzheimerDetectionResult,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(TTexts.close),
            ),
          ],
        );
      },
    );
  }

  // Method to detect Alzheimer's and handle the result
  Future<void> _detectAlzheimers(BuildContext context, int index) async {
    showLoading(context);

    String result = await detectAlz(imagePath);
    controller.selectedImages[index].randomNum = result;
    Navigator.of(context).pop(); // Close the loading dialog
    showResultDialog(context, result); // Show the result dialog
  }

  // Method to detect Alzheimer's by sending the image to the server
  Future<String> detectAlz(String image) async {
    final url = Uri.parse("http://127.0.0.1:5000/upload");

    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('image', image));

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Parse the response body and access the 'shape' value
      Map<String, dynamic> valueMap = json.decode(responseBody);
      String shape = valueMap["shape"];

      String diagnosis;
      if (shape == "Non_Demented") {
        diagnosis = "Normal cognitive function, no dementia.";
      } else if (shape == "Very_Mild_Demented") {
        diagnosis = "Slight memory loss, very mild.";
      } else {
        diagnosis = "Significant impairment, moderate dementia observed.";
      }

      return diagnosis;
    } else {
      Fluttertoast.showToast(
        msg: "Upload failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return "Upload failed";
    }
  }
}



// Future<String> detectAlz(image) async {
//   final url = Uri.parse("http://127.0.0.1:5000/upload");

//   final request = http.MultipartRequest('POST', url)
//     ..files.add(await http.MultipartFile.fromPath('image', image));

//   final response = await request.send();
//   final responseBody = await response.stream.bytesToString();
//   Map valueMap = json.decode(responseBody);
//   if (response.statusCode == 200) {
//     Fluttertoast.showToast(
//       msg: "Successful",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.green,
//       textColor: Colors.white,
//     );
//     return valueMap["shape"];
//   } else if (response.statusCode == 400) {
//     Fluttertoast.showToast(
//       msg: "No image added",
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.red,
//       textColor: Colors.white,
//     );
//     return valueMap["error"];
//   }
//   return "Error Happend";
// }
