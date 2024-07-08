import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controller/auth/signp_controller.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';
import '../../../../core/utils/constants/text_strings.dart';
import '../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/utils/validators/validation.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    final SignUpController _ = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed("/normal_user_login");
          },
          icon: Icon(Iconsax.arrow_left,
              color: dark ? Colors.white : Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  TTexts.signupTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _.username,
                        validator: TValidator.validateUsername,
                        decoration: InputDecoration(
                          labelText: TTexts.username,
                          prefixIcon: const Icon(Iconsax.user),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: _.ssn,
                        keyboardType: TextInputType.number,
                        maxLength: 14,
                        validator: TValidator.validateSsn,
                        decoration: InputDecoration(
                          labelText: TTexts.ssn,
                          prefixIcon: const Icon(Iconsax.card),
                          counterText: '',
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: _.email,
                        validator: TValidator.validateEmail,
                        decoration: InputDecoration(
                          labelText: TTexts.email,
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: _.password,
                        validator: TValidator.validatePassword,
                        obscureText: !_.isPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: TTexts.password,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _.isPasswordVisible.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                            ),
                            onPressed: _.togglePasswordVisibility,
                          ),
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      TextFormField(
                        controller: _.confirmPassword,
                        validator: (value) {
                          if (value != _.password.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        obscureText: !_.isConfirmPasswordVisible.value,
                        decoration: InputDecoration(
                          labelText: TTexts.confirmpassword,
                          prefixIcon: const Icon(Iconsax.password_check),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _.isConfirmPasswordVisible.value
                                  ? Iconsax.eye
                                  : Iconsax.eye_slash,
                            ),
                            onPressed: _.toggleConfirmPasswordVisibility,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: _.isChecked.value,
                        onChanged: _.toggleCheckbox,
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "${TTexts.iAgreeTo} ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: TTexts.privacyPolicy,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(
                                  color: dark ? TColors.white : TColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                          TextSpan(
                            text: " ${TTexts.and} ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: TTexts.termsOfUse,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(
                                  color: dark ? TColors.white : TColors.primary,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _.signUp();

                      // Get.offAllNamed("/login");
                    },
                    child: Text(TTexts.createAccount),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
