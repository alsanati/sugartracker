import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/models/sugar_data.dart';

class HomepageState {
  final String user;
  final List<SugarData> sugarData;

  HomepageState({
    required this.user,
    required this.sugarData,
  });
}
