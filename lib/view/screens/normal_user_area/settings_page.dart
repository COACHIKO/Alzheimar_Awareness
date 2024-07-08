import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/constants/sizes.dart';
import '../../../core/utils/constants/text_strings.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../../../main.dart';
import 'detect_alzheimar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AlzheimarDetectionController controller =
        Get.put(AlzheimarDetectionController());

    var dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark
          ? TColors.dark
          : TColors.light, // Adjust background color as needed
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: TColors.primary, // Adjust color as needed
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TTexts.account,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      ListTile(
                        leading: const Image(
                          image: AssetImage(TImages.user),
                          width: 35,
                          height: 35,
                        ),
                        contentPadding: const EdgeInsets.all(0),
                        title: Text(
                          myServices.sharedPreferences
                              .getString("username")
                              .toString(),
                          style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        subtitle: Text(
                          myServices.sharedPreferences
                              .getString("email")
                              .toString(),
                          style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit,
                              size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.spaceBtwItems),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TTexts.accountSettings,
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections / 3),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: TTexts.myAddress,
                    subtitle: TTexts.setYourHomeAddress,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.scanning,
                    title: TTexts.myScans,
                    subtitle: TTexts.mriScanHistory,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: TTexts.notifications,
                    subtitle: TTexts.setYourCustomNotifications,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: TTexts.accountPrivacy,
                    subtitle: TTexts.manageDataUsageAndAccount,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections / 2),
                  Text(
                    TTexts.appSetting,
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: TTexts.uploadData,
                    subtitle: TTexts.uploadYourDataAsynchronously,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.command,
                    title: TTexts.feedBack,
                    subtitle: TTexts.giveUsAFeedBack,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections / 2),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async {
                        myServices.sharedPreferences.clear();
                        await controller.deleteData();
                        controller.selectedImagePath = ''.obs;
                        controller.selectedImages.clear();
                        Get.offAllNamed("/normal_user_login");
                      },
                      child: Text(TTexts.logout),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TSettingsMenuTile extends StatelessWidget {
  const TSettingsMenuTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.trailing});

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelMedium),
      trailing: trailing,
    );
  }
}
