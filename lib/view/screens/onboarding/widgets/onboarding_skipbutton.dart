import 'package:flutter/material.dart';
import '../../../../../../controller/onboarding.controller.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/utils/device/device_utility.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      left: TSizes.defaultSpace, // Align the button to the left with the same padding
      child: TextButton(
        onPressed: () {
          Onboardingcontroller.instance.skipPage();
        },
        child:Text(TTexts.skip),
      ),
    );
  }
}
