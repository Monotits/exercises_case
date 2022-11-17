import 'package:assistanapp/services/search_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/exercises/exercises.dart';

class SearchController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getRandomExercises();
  }

  //* Exercises List
  RxList<Exercises> exercisesList = <Exercises>[].obs;

  //* Service data is ok?
  Rx<bool> loadingIsOk = false.obs;

  //* Search result text
  Rx<String> searchResultTitle = ''.obs;

  //* Get random exercises data. (No search text or filters)
  void getRandomExercises() async {
    exercisesList.value = [];
    exercisesList.value = await SearchServices.getExercisesData();
    searchResultTitle.value = 'Most preferred exercises';
    loadingIsOk.value = true;
  }

  //* Get exercises data with search text or filters
  void getSearchExercises() async {
    searchResultTitle.value = '';
    exercisesList.value = [];
    exercisesList.value = await SearchServices.getExercisesData(
        parameters: getUrlParameters(
      searchTextController.text,
      muscleValue.value,
      typeValue.value,
    ));
    if (searchTextController.text == '' && muscleValue.value == 'Choose Muscle' && typeValue.value == 'Choose Type') {
      searchResultTitle.value = 'Most preferred exercises';
    } else {
      searchResultTitle.value = '${exercisesList.length} results found.';
    }
    update();
  }

  //* Get url parameters from search text and filters
  String getUrlParameters(String searchKey, String muscleKey, String typeKey) {
    if (searchKey == '' && muscleKey == 'Choose Muscle' && typeKey == 'Choose Type') {
      return '';
    } else if (searchKey != '' && muscleKey == 'Choose Muscle' && typeKey == 'Choose Type') {
      return 'name=$searchKey';
    } else if (searchKey != '' && muscleKey != 'Choose Muscle' && typeKey == 'Choose Type') {
      return 'name=$searchKey&muscle=${muscleValue.toLowerCase()}';
    } else if (searchKey != '' && muscleKey != 'Choose Muscle' && typeKey != 'Choose Type') {
      return 'name=$searchKey&muscle=${muscleValue.toLowerCase()}&type=${typeValue.toLowerCase()}';
    } else if (searchKey == '' && muscleKey != 'Choose Muscle' && typeKey != 'Choose Type') {
      return 'muscle=${muscleValue.toLowerCase()}&type=${typeValue.toLowerCase()}';
    } else if (searchKey == '' && muscleKey == 'Choose Muscle' && typeKey != 'Choose Type') {
      return 'type=${typeValue.toLowerCase()}';
    } else if (searchKey != '' && muscleKey == 'Choose Muscle' && typeKey != 'Choose Type') {
      return 'name=$searchKey&type=${typeValue.toLowerCase()}';
    } else if (searchKey == '' && muscleKey != 'Choose Muscle' && typeKey == 'Choose Type') {
      return 'muscle=${muscleValue.toLowerCase()}';
    } else {
      debugPrint('Error with parameters conditions!');
      return '';
    }
  }

  //* Search fields - Text controller
  TextEditingController searchTextController = TextEditingController();

  //* Muscle value - Dropdown Menu
  Rx<String> muscleValue = 'Choose Muscle'.obs;
  List<String> muscleTitleList = <String>[
    'Choose Muscle',
    'Abdominals',
    'Abductors',
    'Adductors',
    'Biceps',
    'Calves',
    'Chest',
    'Forearms',
    'Glutes',
    'Hamstrings',
    'Lats',
    'Lowerback middleback',
    'Neck',
    'Quadriceps',
    'Traps',
    'Triceps',
  ];

  //* Type value - Dropdown Menu
  RxString typeValue = 'Choose Type'.obs;
  List<String> typeTitleList = <String>[
    'Choose Type',
    'Cardio',
    'Olympic_weightlifting',
    'Plyometrics',
    'Powerlifting',
    'Strength',
    'Stretching',
    'Strongman',
  ];
}
