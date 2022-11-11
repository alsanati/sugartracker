import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_quickstart/app/pages/account_page.dart';
import 'package:supabase_quickstart/app/pages/login_page.dart';
import 'package:supabase_quickstart/app/pages/splash_page.dart';

import 'app/pages/homepage.dart';

Future<void> main() async {
  await Supabase.initialize(
    // TODO: Replace credentials with your own
    url: 'https://vplernwrerwdcyoymbwx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZwbGVybndyZXJ3ZGN5b3ltYnd4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njc5MTUyMTUsImV4cCI6MTk4MzQ5MTIxNX0.KW-RIscnzX4UKFCQ7oMVDckZIJwyOkF2fUmLH-QM6tc',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suggra',
      theme: ThemeData.light().copyWith(
        useMaterial3: true,
        primaryColor: Colors.blue,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        "/home": (_) => const Homepage(),
      },
    );
  }
}
