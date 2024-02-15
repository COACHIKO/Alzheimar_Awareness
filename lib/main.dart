import 'package:alzaware/view/screens/authentication/login/login_page.dart';
import 'package:alzaware/view/screens/authentication/signup/sign_up.dart';
import 'package:alzaware/view/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
 import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'core/utils/constants/text_strings.dart';
import 'core/utils/theme/theme.dart';
LocaleController localeController = LocaleController();

MyServices myServices = Get.find();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(ALZAware());

}
class ALZAware extends StatelessWidget {
  ALZAware({super.key});
final  LocaleController langController = Get.put(LocaleController());

    @override
  Widget build(BuildContext context) {
      return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, child) {
          return GetMaterialApp(
           title: TTexts.appName,
           themeMode: ThemeMode.system,
           theme: TAppTheme.lightTheme,
           darkTheme: TAppTheme.darkTheme,
           locale: langController.language,
           translations: MyTranslation(),
            initialRoute: "/onboarding",
            routes:{

              "/onboarding":(context)=> const OnboardingScreen(),
              "/login":(context)=> const LoginPage(),
              "/signup":(context)=> const SignUp(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      );
    }}

