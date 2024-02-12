import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/device/device_utility.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers.onboarding/onboarding.controller.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var dark=THelperFunctions.isDarkMode(context);

    return Positioned(right: TSizes.defaultSpace,bottom: TDeviceUtils.getBottomNavigationBarHeight(),
        child: ElevatedButton(style:ElevatedButton.styleFrom(shape: CircleBorder(),backgroundColor:dark? TColors.primary:Colors.black) ,onPressed: (){Onboardingcontroller.instance.nextpage();}, child: const Icon( Icons.arrow_forward_ios,color: Colors.white,)));
  }
}
