import 'package:courier/Screen/Widgets/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Controllers/global-controller.dart';
import 'Locale/language.dart';
import 'Screen/SplashScreen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final box = GetStorage();
  await GetStorage.init();
  dynamic langValue = const Locale('ar', 'AR');
  if (box.read('lang') != null) {
    langValue = Locale(box.read('lang'), box.read('langKey'));
  } else {
    langValue = const Locale('ar', 'AR');
  }
  runApp(MyApp(lang: langValue));
}

class MyApp extends StatelessWidget {
  final Locale lang;

  MyApp({Key? key, required this.lang}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: kBgColor,
          // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.put(GlobalController()).onInit();

    return ScreenUtilInit(
      designSize: Size(360, 800),
      builder: ((context, child) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: Languages(),
            locale: lang,
            title: 'ونتكس مناديب',
            theme: ThemeData(
                    fontFamily: 'Display',
                    primaryColor: kMainColor,
                    focusColor: kMainColor)
                .copyWith(
              colorScheme:
                  ThemeData().colorScheme.copyWith(primary: kMainColor),
            ),
            home: const SplashScreen(),
          )),
    );
  }
}
