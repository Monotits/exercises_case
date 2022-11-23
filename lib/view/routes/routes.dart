// ignore_for_file: public_member_api_docs

import 'package:assistanapp/controllers/search_controller.dart';
import 'package:get/get.dart';

import '../screens/search_screen/search_screen.dart';

mixin Routes {
  static List<GetPage> routesList = [
    GetPage(
      name: '/searchScreen',
      page: () => SearchScreen(),
      binding: BindingsBuilder(() => {Get.put(SearchController())}),
    ),
  ];
}
