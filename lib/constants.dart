import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

abstract class Constants {
  static const String supabaseUrl = String.fromEnvironment(
    'https://vplernwrerwdcyoymbwx.supabase.co',
    defaultValue: "",
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwbGVybndyZXJ3ZGN5b3ltYnd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njc5MTUyMTUsImV4cCI6MTk4MzQ5MTIxNX0.KW-RIscnzX4UKFCQ7oMVDckZIJwyOkF2fUmLH-QM6tc',
    defaultValue: "",
  );
}

var test = "lol";
