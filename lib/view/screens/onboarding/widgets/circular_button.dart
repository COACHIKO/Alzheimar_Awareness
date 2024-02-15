import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../../controller/onboarding.controller.dart';
import '../../../../core/localization/changelocal.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/device/device_utility.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var dark=THelperFunctions.isDarkMode(context);
    var isArabic = LocaleController().language == const Locale("ar");

    return Positioned(right: TSizes.defaultSpace,bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(style:ElevatedButton.styleFrom(shape: const CircleBorder(),backgroundColor:dark? TColors.primary:Colors.black) ,onPressed: (){Onboardingcontroller.instance.nextpage();}, child: Icon(  isArabic?Icons.arrow_back_ios:Icons.arrow_forward_ios,color: Colors.white,)));
  }
}
Icon getIconBasedOnLanguage(isArabic) {
  if (isArabic==true) {
    return const Icon(Icons.arrow_forward_ios,color: Colors.white,);
  } else  {
    return const Icon(Icons.arrow_back_ios,color: Colors.white,);
  }
}