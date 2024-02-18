import 'package:alzaware/core/utils/helpers/helper_functions.dart';
import 'package:alzaware/view/screens/home_screen.dart';
import 'package:alzaware/view/screens/normal_user_area/detect_alzheimar.dart';
 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/constants/colors.dart';

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
    destinations: const [
      NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
      NavigationDestination(icon: Icon(Iconsax.scan), label: "Scan"),
      NavigationDestination(icon: Icon(Iconsax.hospital), label: "Hospital"),
      NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),

    ],
    )),
    body:Obx(()=>controller.screens[controller.selectedIndex.value],));
  }
}

class NavigationController extends GetxController{
  static NavigationController get instance => Get.find();
  final Rx<int> selectedIndex=0.obs;
  final screens = [  HomePage(),AlzheimerDetection(),Container(color: Colors.green,),Container(color: Colors.yellow,)];
}
