import 'package:flutter/material.dart';

class AppRadius extends BorderRadius {
  const AppRadius.big() : super.all(const Radius.circular(15));
  const AppRadius.medium() : super.all(const Radius.circular(10));
  const AppRadius.small() : super.all(const Radius.circular(5));
}
