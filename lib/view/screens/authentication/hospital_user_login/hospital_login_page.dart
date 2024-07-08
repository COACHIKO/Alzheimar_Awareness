import 'package:alzaware/controller/auth/hospital_user_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/common/styles/spacing_styles.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/image_strings.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../../core/utils/constants/text_strings.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../core/utils/validators/validation.dart';
import '../password_configiration/forget_password.dart';

class HospitalLoginPage extends StatelessWidget {
  final HospitalUserLoginController _loginController =
      Get.put(HospitalUserLoginController());
  HospitalLoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    var dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: TSpacingStyle.paddingWithAppBarHight,
        child: Obx(
          () => Form(
            key: _loginController.formKeys.value,
            child: Column(
              children: [
                // Logo title subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image(
                        height: 120,
                        image: AssetImage(
                            dark ? TImages.lightAppLogo : TImages.darkAppLogo),
                      ),
                    ),
                    Text(
                      TTexts.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: TSizes.sm),
                    Text(
                      TTexts.hosptiatlLogin,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),

                // Form
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    children: [
                      // SSN TEXTFORMFIELD
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 14,
                        controller: _loginController.email,
                        validator: TValidator.validateSsn, // Validation for SSN
                        decoration: InputDecoration(
                          labelText: TTexts.ssn,
                          prefixIcon: const Icon(Iconsax.card),
                          counterText: '', // Clear default counter text
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),

                      // Password TEXTFORMFIELD
                      TextFormField(
                        controller: _loginController.passwordController,
                        validator: TValidator
                            .validatePassword, // Validation for password
                        obscureText: _loginController.obscurePassword.value,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password_outlined),
                          suffixIcon: IconButton(
                            icon: Icon(_loginController.obscurePassword.value
                                ? Iconsax.eye_slash
                                : Iconsax.eye),
                            onPressed:
                                _loginController.togglePasswordVisibility,
                          ),
                          labelText: TTexts.password,
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields / 2),

                      // Remember me & Forget Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Remember me
                          Row(
                            children: [
                              Checkbox(
                                value: _loginController.rememberMe.value,
                                onChanged: _loginController.toggleRememberMe,
                              ),
                              Text(TTexts.rememberMe),
                            ],
                          ),

                          // Forget Password
                          TextButton(
                            onPressed: () {
                              Get.to(const ForgetPassword());
                            },
                            child: Text(TTexts.forgetPassword),
                          ),
                        ],
                      ),

                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Sign In button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _loginController.signIn();
                          },
                          child: Text(TTexts.signIn),
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
