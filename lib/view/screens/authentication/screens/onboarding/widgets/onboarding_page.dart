import 'package:flutter/material.dart';

import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key, required this.image, required this.subtitle,required this.title,
  });

  final String image,title,subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [

        Image(
            width:THelperFunctions.screenWidth()*.6,
            height:THelperFunctions.screenHeight()*0.6,
            image:   AssetImage(image,),),
        Text(title,style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(subtitle,style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center,)

      ],),
    );
  }
}
