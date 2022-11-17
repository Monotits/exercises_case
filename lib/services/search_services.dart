import 'package:assistanapp/core/constants/app_strings.dart';
import 'package:assistanapp/models/exercises/exercises.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constants/app_url.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchServices {
  //* Header
  static final Map<String, String> _headers = {
    "x-rapidapi-key": AppString.rapidApiKey,
  };
  //* Get Exercises Data Service
  static Future<List<Exercises>> getExercisesData({String? parameters}) async {
    Uri uri = Uri.parse('${AppUrls.url}${parameters ?? ''}');
    try {
      final response = await http.get(uri, headers: _headers);
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List).map((l) => Exercises.fromJson(l)).toList();
      } else {
        throw Exception('Failed to load json data');
      }
    } catch (e) {
      throw Exception('Server Internal Error');
    }
  }
}
