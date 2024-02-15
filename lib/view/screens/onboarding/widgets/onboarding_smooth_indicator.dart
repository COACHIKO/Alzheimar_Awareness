import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../../controller/onboarding.controller.dart';
import '../../../../core/localization/changelocal.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class OnboardingSmoothIndicator extends StatelessWidget {const OnboardingSmoothIndicator({super.key,});
  @override
    Widget build(BuildContext context) {
    LocaleController localeController = LocaleController();

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
