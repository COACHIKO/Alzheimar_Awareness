import 'package:alzaware/view/screens/authentication/password_configiration/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../../core/utils/constants/text_strings.dart';
class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(),body:Padding(padding: const EdgeInsets.all(TSizes.defaultSpace),child:
    Column( crossAxisAlignment:CrossAxisAlignment.start ,
      children: [
        /// HEADING
        Text(TTexts.forgetPasswordTitle,style:Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: TSizes.spaceBtwItems,),
        Text(TTexts.forgetPasswordSubTitle,style:Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: TSizes.spaceBtwItems*2,),

        /// TEXTFORMFIELD
        TextFormField(decoration:  InputDecoration(labelText: TTexts.email,prefixIcon: Icon(Iconsax.direct_right)),),

/// SUBMIT
        const SizedBox(height: TSizes.spaceBtwSections,),

        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){Get.off(const ResetPassword());}, child: Text(TTexts.submit))),

      ],),),);
  }
}
