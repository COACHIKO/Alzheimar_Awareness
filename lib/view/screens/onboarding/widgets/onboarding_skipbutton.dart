import 'package:flutter/material.dart';
import '../../../../controller/onboarding_controller.dart';
import '../../../../core/localization/changelocal.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/utils/device/device_utility.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isArabic = LocaleController().language == const Locale("ar");

    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: isArabic ? null : TSizes.defaultSpace, // If Arabic, set left to null (default position)
      left: isArabic ? TSizes.defaultSpace : null, // If not Arabic, set right to null (default position)
      child: TextButton(
        onPressed: () {
          Onboardingcontroller.instance.skipPage();
        },
        child:Text(TTexts.skip),
      ),
    );
  }
}
