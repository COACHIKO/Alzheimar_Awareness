import 'package:alzaware/view/screens/authentication/screens/onboarding/widgets/circular%20button.dart';
import 'package:alzaware/view/screens/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:alzaware/view/screens/authentication/screens/onboarding/widgets/onboarding_skipbutton.dart';
import 'package:alzaware/view/screens/authentication/screens/onboarding/widgets/onboarding_smooth_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../controllers.onboarding/onboarding.controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Onboardingcontroller());

    return  Scaffold(body: Stack(children: [
      /// Horizontal scrollable Pages
        PageView(controller: controller.pageController,
          onPageChanged:controller.updatePageIndicator,children:  const [
    OnboardingPage(image: TImages.onBoardingImage1,title: TTexts.onBoardingTitle1,subtitle:TTexts.onBoardingSubTitle1,),
    OnboardingPage(image: TImages.onBoardingImage2,title: "Alzheimer's Managing App",subtitle:TTexts.onBoardingSubTitle2,),
    OnboardingPage(image: TImages.onBoardingImage3,title: "Alzheimer Healthcare",subtitle:TTexts.onBoardingSubTitle3,)
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



