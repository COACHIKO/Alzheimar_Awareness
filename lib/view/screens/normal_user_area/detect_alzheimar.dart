import 'dart:io';
import 'package:alzaware/core/utils/constants/image_strings.dart';
import 'package:alzaware/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../app_wide_widgets/custom_appbar.dart';
import 'dart:async';
import 'dart:math';
class AlzheimerDetection extends StatelessWidget {
  const AlzheimerDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    final AlzheimarDetectionController controller =
    Get.put(AlzheimarDetectionController());

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(showBackArrow: false, title: "Alzheimer Detection",),
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
            padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems),
            child: const Text("We Have Developed an Artificial Intelligence Doctor Who Never Makes A Mistake, Trust Him."),
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
                      Image(height: 120, image: AssetImage(dark ? TImages.uploadImageLight : TImages.uploadImageDark)),
                      const Text("Upload Image"),
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
                      Image(height: 120, image: AssetImage(dark ? TImages.takephoto : TImages.takephoto)),
                      const Text("Take Photo"),
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

                // تحويل التاريخ والوقت إلى الشكل المطلوب
                var formattedDateTime = DateFormat('E-dd-MM-yyyy\nhh:mm a').format(dateTime);

                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(image),
                      ),
                      title: Text('MRI ${index + 1}'),
                      subtitle: Text(formattedDateTime), // استخدام التنسيق الجديد للتاريخ والوقت
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {
                              controller.viewImage(index);
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
  RxList<ImageWithDateTime> selectedImages = <ImageWithDateTime>[].obs;

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImages.add(ImageWithDateTime(pickedFile.path, DateTime.now())); // تاريخ ووقت الآن
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value = "${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)}Mb";

      Get.snackbar(
        "Success",
        "Image Selected",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    } else {
      Get.snackbar(
        "Error",
        "No Image Selected",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
      );
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  void viewImage(int index) {
    final imagePath = selectedImages[index].imagePath;
    Get.to(ViewImageScreen(imagePath: imagePath));
  }
}

class ImageWithDateTime {
  final String imagePath;
  final DateTime dateTime;

  ImageWithDateTime(this.imagePath, this.dateTime);
}


// تعريف المتغير العشوائي لنسبة المرض
final Random _random = Random();

// دالة توليد نتيجة عشوائية لنسبة المرض
double _generateRandomPercentage() {
  return _random.nextDouble() * 100; // توليد رقم عشوائي بين 0 و 100
}

class ViewImageScreen extends StatelessWidget {
  final String imagePath;

  const ViewImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(showBackArrow: true, title: "View And Detect"),
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
                  onPressed: () {
                    // تشغيل عملية التحميل المزيفة
                    showFakeLoading(context);
                  },
                  child: const Text("Detect Alzheimer"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة عرض الشاشة المزيفة لعملية التحميل
  void showFakeLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text("Detecting Alzheimer..."),
              ],
            ),
          ),
        );
      },
    );
    // بعد 5 ثواني، إغلاق شاشة التحميل وعرض النتيجة
    Timer(const Duration(seconds: 5), () {
      Navigator.pop(context); // إغلاق شاشة التحميل
      showResultDialog(context);
    });
  }

  // دالة عرض نتيجة الفحص المزيفة
  void showResultDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // توليد نسبة مرض عشوائية
        final double percentage = _generateRandomPercentage();
        return AlertDialog(
          title: const Text("Alzheimer Detection Result"),
          content: Text(
            percentage < 50
                ? "No signs of Alzheimer's detected. Percentage: ${percentage.toStringAsFixed(2)}%"
                : "Alzheimer's detected with ${percentage.toStringAsFixed(2)}% confidence.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
