import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

import '../../../controllers.onboarding/onboarding.controller.dart';

class OnboardingSmoothIndicator extends StatelessWidget {
  const OnboardingSmoothIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller=Onboardingcontroller.instance;
    var dark=THelperFunctions.isDarkMode(context);
    return Positioned(bottom:TDeviceUtils.getBottomNavigationBarHeight()+25,
        left: TSizes.defaultSpace,
        child: SmoothPageIndicator(
          effect:   ExpandingDotsEffect(activeDotColor: dark?TColors.light:TColors.dark,dotHeight: 6),
          controller: controller.pageController,count:3,
          onDotClicked: controller.dotNavigationClick,));
  }
}
