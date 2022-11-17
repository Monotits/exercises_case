import 'package:assistanapp/controllers/search_controller.dart';
import 'package:assistanapp/core/constants/app_colors.dart';
import 'package:assistanapp/core/constants/app_textstyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_radius.dart';
import '../../widgets/buttons/filter_buttons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  //* Find Search Controller
  SearchController searchController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      primary: true,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Obx(
          () => CustomScrollView(
            slivers: [
              sliverAppBarWidget(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, int index) {
                    return searchController.loadingIsOk.value
                        ? searchResultCardWidget(index)
                        : index == 0
                            ? loadingWidget()
                            : const SizedBox.shrink();
                  },
                  childCount: searchController.exercisesList.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //* Sliver App Bar Widget on Top (Search & Filter Button)
  Widget sliverAppBarWidget() {
    return SliverAppBar(
      expandedHeight: 170,
      collapsedHeight: 120,
      pinned: true,
      backgroundColor: AppColors.backgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        title: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 30),
          child: Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  searchTextFormFieldWidget(),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        filterWidget(),
                        backgroundColor: AppColors.backgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                        ),
                      );
                    },
                    child: filterIconWidget(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                searchController.searchResultTitle.value,
                style: AppTextStyle.titleText,
              )
            ],
          ),
        ),
      ),
    );
  }

  //* Filter Icon Button Widget
  Widget filterIconWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.whiteColor),
      child: const Icon(
        CupertinoIcons.slider_horizontal_3,
        size: 25,
      ),
    );
  }

  //* Search Area Widget - TextFormField
  Widget searchTextFormFieldWidget() {
    return Container(
      width: Get.width * 0.8,
      height: 50,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(borderRadius: AppRadius.big(), color: AppColors.whiteColor),
      child: TextFormField(
        controller: searchController.searchTextController,
        onEditingComplete: () {
          FocusManager.instance.primaryFocus?.unfocus();
          searchController.getSearchExercises();
        },
        decoration: InputDecoration(border: InputBorder.none, hintText: 'Search', hintStyle: TextStyle(fontSize: Get.width * 0.035)),
      ),
    );
  }

  //* Choose Filter Widget - ModalBottomSheet
  Widget filterWidget() {
    return StatefulBuilder(builder: (context, setState) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 20, 0),
        child: SizedBox(
          height: Get.height * 0.3,
          width: Get.width,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Type: ',
                    style: AppTextStyle.titleText,
                  ),
                  DropdownButton(
                    underline: const SizedBox(),
                    // Initial Value
                    value: searchController.typeValue.value,

                    // Down Arrow Icon
                    icon: Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.15),
                      child: const Icon(
                        CupertinoIcons.chevron_down,
                        color: AppColors.blackColor,
                      ),
                    ),
                    // Array list of items
                    items: searchController.typeTitleList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: AppTextStyle.titleText.copyWith(color: AppColors.blackColor),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      searchController.typeValue.value = newValue!;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Muscle: ',
                    style: AppTextStyle.titleText,
                  ),
                  DropdownButton(
                    underline: const SizedBox(),
                    // Initial Value
                    value: searchController.muscleValue.value,

                    // Down Arrow Icon
                    icon: Padding(
                      padding: EdgeInsets.only(left: Get.width * 0.085),
                      child: const Icon(
                        CupertinoIcons.chevron_down,
                        color: AppColors.blackColor,
                      ),
                    ),
                    // Array list of items
                    items: searchController.muscleTitleList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          style: AppTextStyle.titleText.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      searchController.muscleValue.value = newValue!;
                      setState(() {});
                    },
                  ),
                ],
              ),
              // Apply and clear buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox.shrink(),
                  FilterButtonWidget(
                    searchController: searchController,
                    title: 'Apply',
                    onPress: () {
                      searchController.getSearchExercises();
                      Get.back();
                    },
                  ),
                  FilterButtonWidget(
                    searchController: searchController,
                    title: 'Clear',
                    onPress: () {
                      searchController.muscleValue.value = 'Choose Muscle';
                      searchController.typeValue.value = 'Choose Type';
                      searchController.getSearchExercises();
                      Get.back();
                    },
                  ),
                  const SizedBox.shrink(),
                ],
              )
            ],
          ),
        ),
      );
    });
  }

  //* Search Result Card Widget
  Widget searchResultCardWidget(int index) {
    return Padding(
      padding: EdgeInsets.only(
        top: (index == 0) ? 20 : 10,
        left: 15,
        right: 15,
        bottom: (index == searchController.exercisesList.length - 1) ? 50 : 10,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        width: Get.width * 0.9,
        decoration: const BoxDecoration(borderRadius: AppRadius.medium(), color: AppColors.whiteColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              searchController.exercisesList[index].name!,
              style: AppTextStyle.cardTitle,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(borderRadius: const AppRadius.big(), color: AppColors.greyColor.withOpacity(0.7)),
              child: Text(searchController.exercisesList[index].type!, style: AppTextStyle.cardType),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              searchController.exercisesList[index].muscle!.toUpperCase(),
              style: AppTextStyle.cardDetail,
            ),
          ],
        ),
      ),
    );
  }

  //* Loading Circular Progress Indicator Widget
  Widget loadingWidget() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: Get.width * 0.5, horizontal: Get.width * 0.45),
        child: const CircularProgressIndicator(
          color: AppColors.blackColor,
        ));
  }
}
