import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppString {
  AppString._();

  static String appName = 'Assistant App';
  static String rapidApiKey = dotenv.env['rapidApiKey']!;
}
