import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationHelper on BuildContext {
  static const String homePage = '/home';
  static const String settingsPage = '/settings';
  static const String stepperPage = '/stepper';

  void go(String page) {
    GoRouter.of(this).go(page);
  }
}
