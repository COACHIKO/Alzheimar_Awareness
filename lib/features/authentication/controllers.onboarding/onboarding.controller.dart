import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/login/login_page.dart';

class Onboardingcontroller extends GetxController{
  static Onboardingcontroller get instance =>Get.find();
final pageController = PageController();
  Rx<int> currentPageIndex=0.obs;
  void updatePageIndicator(index)=>currentPageIndex.value=index;
  void dotNavigationClick(index){
    currentPageIndex.value=index;
    pageController.jumpToPage(index);
  }
  void nextpage(){
    if(currentPageIndex.value==2){
      Get.offAll(const LoginPage());

    }else{
      int page = currentPageIndex.value+1;
      pageController.jumpToPage(page);
    }
  }
  void skipPage(){
    currentPageIndex.value=2;
    pageController.jumpToPage(2);

  }
}