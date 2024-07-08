import 'package:alzaware/view/screens/authentication/hospital_user_login/hospital_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../core/utils/constants/image_strings.dart';
import '../core/utils/constants/sizes.dart';
import '../core/utils/constants/text_strings.dart';
import '../core/utils/helpers/helper_functions.dart';
import '../view/screens/authentication/normal_user_login/login_page.dart';

class Onboardingcontroller extends GetxController {
  static Onboardingcontroller get instance => Get.find();
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  void updatePageIndicator(index) => currentPageIndex.value = index;
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextpage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(const ForkUsering());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}

class ForkUsering extends StatelessWidget {
  const ForkUsering({super.key});

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 80.0.h),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.spaceBtwItems),
                  child: Text(TTexts.forkHead,
                      style: Theme.of(context).textTheme.bodyLarge!),
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () async {
                          Get.off(HospitalLoginPage());
                        },
                        child: const Column(
                          children: [
                            Image(
                                height: 120,
                                image: AssetImage(TImages.hospital)),
                            Text("Relative User"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () async {
                          Get.off(NormalUserLoginPage());
                        },
                        child: Column(
                          children: [
                            const Image(
                                height: 120, image: AssetImage(TImages.self)),
                            Text(TTexts.selfUser),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
