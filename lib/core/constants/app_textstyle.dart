import 'package:assistanapp/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextStyle {
  AppTextStyle._();

  static final titleText = TextStyle(fontSize: Get.width * 0.04, color: AppColors.blackColor, fontWeight: FontWeight.normal);
  static final cardTitle = TextStyle(fontSize: Get.width * 0.04, color: AppColors.blackColor, fontWeight: FontWeight.normal);
  static final cardType = TextStyle(fontSize: Get.width * 0.03, color: AppColors.whiteColor, fontWeight: FontWeight.normal);
  static final cardDetail = TextStyle(fontSize: Get.width * 0.035, color: AppColors.blackColor, fontWeight: FontWeight.normal);
}
