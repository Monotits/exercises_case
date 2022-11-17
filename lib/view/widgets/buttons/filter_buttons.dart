import 'package:flutter/material.dart';

import '../../../controllers/search_controller.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyle.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({
    Key? key,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
          onPressed: onPress,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.whiteColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: AppTextStyle.cardTitle.copyWith(fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
