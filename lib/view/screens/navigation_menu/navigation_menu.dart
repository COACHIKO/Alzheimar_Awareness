import 'package:alzaware/core/utils/helpers/helper_functions.dart';
import 'package:alzaware/view/screens/diagnosis_history.dart';
import 'package:alzaware/view/screens/normal_user_area/detect_alzheimar.dart';
import 'package:alzaware/view/screens/normal_user_area/settings_page.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/text_strings.dart';
import '../normal_user_area/symptoms_page.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);

    return  Scaffold(bottomNavigationBar: Obx(
            ()=>NavigationBar(
              height: 80,
              elevation: 0,
              selectedIndex: controller.selectedIndex.value,
              onDestinationSelected: (index) => controller.selectedIndex.value=index,
              backgroundColor:darkMode?TColors.black:Colors.white,
              indicatorColor: darkMode?TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),
    destinations:   [
              NavigationDestination(icon: const Icon(Iconsax.scan),label:TTexts.scan),
              NavigationDestination(icon: const Icon(Iconsax.previous),label:TTexts.history),
              NavigationDestination(icon: const Icon(Iconsax.signpost),label:TTexts.symptoms),
              NavigationDestination(icon: const Icon(Iconsax.user),label:TTexts.profile  ),

    ],
    )),
    body:Obx(()=>controller.screens[controller.selectedIndex.value],));
  }
}

class NavigationController extends GetxController{
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex=0.obs;
  final screens = [ const AlzheimerDetection(),const DiagnosisHistory(),SymptomsPage(),const SettingScreen()];
}

