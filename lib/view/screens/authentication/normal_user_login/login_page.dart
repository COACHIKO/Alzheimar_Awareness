import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../core/common/styles/spacing_styles.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/image_strings.dart';
import '../../../../../core/utils/constants/sizes.dart';
import '../../../../../core/utils/constants/text_strings.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../../controller/auth/normal_user_login_controller.dart';
import '../../../../core/utils/validators/validation.dart';
import '../password_configiration/forget_password.dart';

class NormalUserLoginPage extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  NormalUserLoginPage({super.key});
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
                      TTexts.loginSubTitle,
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
                        keyboardType: TextInputType.emailAddress,
                        // maxLength: 14,
                        controller: _loginController.email,
                        validator:
                            TValidator.validateEmail, // Validation for SSN
                        decoration: InputDecoration(
                          labelText: TTexts.email,
                          prefixIcon: const Icon(Icons.email_outlined),
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
                          onPressed: () {
                            _loginController.signIn();
                            // _loginController.signIn,
                          },
                          child: Text(TTexts.signIn),
                        ),
                      ),

                      const SizedBox(height: TSizes.spaceBtwItems),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Get.offNamed("/signup");
                          },
                          child: Text(TTexts.createAccount),
                        ),
                      ),
                    ],
                  ),
                ),

                // Divider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Divider(
                        color: dark ? TColors.darkGrey : TColors.grey,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 5,
                      ),
                    ),
                    Text(
                      TTexts.orSignInWith,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Flexible(
                      child: Divider(
                        color: dark ? TColors.darkGrey : TColors.grey,
                        thickness: 0.5,
                        indent: 5,
                        endIndent: 60,
                      ),
                    ),
                  ],
                ),

                // Footer
                const SizedBox(height: TSizes.spaceBtwSections),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          width: TSizes.iconMd,
                          height: TSizes.iconMd,
                          image: AssetImage(TImages.google),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          width: TSizes.iconMd,
                          height: TSizes.iconMd,
                          image: AssetImage(TImages.facebook),
                        ),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: TColors.grey),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Image(
                          width: TSizes.iconMd,
                          height: TSizes.iconMd,
                          image: AssetImage(TImages.appleLogo),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
