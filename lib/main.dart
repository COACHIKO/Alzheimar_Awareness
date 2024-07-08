import 'package:alzaware/view/screens/authentication/normal_user_login/login_page.dart';
import 'package:alzaware/view/screens/authentication/signup/sign_up.dart';
import 'package:alzaware/view/screens/navigation_menu/navigation_menu.dart';
import 'package:alzaware/view/screens/normal_user_area/detect_alzheimar.dart';
import 'package:alzaware/view/screens/onboarding/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'core/localization/changelocal.dart';
import 'core/localization/translation.dart';
import 'core/services/services.dart';
import 'core/utils/constants/text_strings.dart';
import 'core/utils/theme/theme.dart';

LocaleController localeController = LocaleController();
MyServices myServices = Get.find();
Box? mybox;
Future<Box> openHiveBox(String boxname) async {
  if (!Hive.isBoxOpen(boxname)) {
    Hive.init((await getApplicationDocumentsDirectory()).path);
  }
  return await Hive.openBox(boxname);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  if (!Hive.isAdapterRegistered(0)) {
    Hive.init(appDocumentDirectory.path);
  }
  Hive.registerAdapter(ImageWithDateTimeAdapter());
  mybox = await openHiveBox("client");

  runApp(ALZAware());
}

class ALZAware extends StatelessWidget {
  ALZAware({super.key});
  final LocaleController langController = Get.put(LocaleController());
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
          theme: localeController.language == const Locale("ar")
              ? TAppTheme.lightArTheme
              : TAppTheme.lightTheme,
          darkTheme: localeController.language == const Locale("ar")
              ? TAppTheme.darkArTheme
              : TAppTheme.darkTheme,
          locale: langController.language,
          translations: MyTranslation(),
          initialRoute: myServices.sharedPreferences.getString("token") ==
                      null ||
                  myServices.sharedPreferences.getBool("rememberme") == false
              ? "/onboarding"
              : "/homeScreen",
          routes: {
            "/onboarding": (context) => const OnboardingScreen(),
            "/normal_user_login": (context) => NormalUserLoginPage(),
            "/signup": (context) => const SignUpPage(),
            "/alzheimerdetection": (context) => const AlzheimerDetection(),
            "/homeScreen": (context) => const NavigationMenu(),
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
