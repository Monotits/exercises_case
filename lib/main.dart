import 'package:assistanapp/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

import 'core/constants/app_language.dart';
import 'view/routes/routes.dart';

void main() async {
  // Load Api Key from .env file
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      translations: AppLanguage(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'EN'),
      initialRoute: '/searchScreen',
      getPages: Routes.routesList,
    );
  }
}
