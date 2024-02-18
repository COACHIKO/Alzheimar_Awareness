import 'package:alzaware/view/screens/onboarding/widgets/circular_button.dart';
import 'package:alzaware/view/screens/onboarding/widgets/onboarding_page.dart';
import 'package:alzaware/view/screens/onboarding/widgets/onboarding_skipbutton.dart';
import 'package:alzaware/view/screens/onboarding/widgets/onboarding_smooth_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../controller/onboarding_controller.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Onboardingcontroller());

    return  Scaffold(body: Stack(children: [
      /// Horizontal scrollable Pages
        PageView(controller: controller.pageController,
          onPageChanged:controller.updatePageIndicator,children:   [
    OnboardingPage(image: TImages.onBoardingImage1,title: TTexts.onBoardingTitle1,subtitle:TTexts.onBoardingSubTitle1,),
    OnboardingPage(image: TImages.onBoardingImage2,title: TTexts.onBoardingTitle2,subtitle:TTexts.onBoardingSubTitle2,),
    OnboardingPage(image: TImages.onBoardingImage3,title: TTexts.onBoardingTitle3,subtitle:TTexts.onBoardingSubTitle3,)
  ],),
      /// Skip button
      const OnboardingSkipButton(),
      /// Dot Navigation SmoothIndicator
      const OnboardingSmoothIndicator(),
       /// Circular button
      const CircularButton()

    ],),);
  }
}



