import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers.onboarding/onboarding.controller.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(top: TDeviceUtils.getAppBarHeight(),right: TSizes.defaultSpace,child: TextButton(onPressed: (){Onboardingcontroller.instance.skipPage();}, child: const Text("Skip")));
  }
}
