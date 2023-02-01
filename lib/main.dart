// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sugar_tracker/app/views/account_views/account_page.dart';
import 'package:sugar_tracker/app/views/account_views/login_page.dart';
import 'package:sugar_tracker/app/views/account_views/splash_page.dart';

import 'app/components/bottomNav.dart';
import 'app/views/homepage.dart';
import 'app/views/account_views/signup_page.dart';
import 'constants.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
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
        '/': (_) => const BottomNav(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        "/home": (_) => const Homepage(),
        "/signup": (_) => const SignUpPage(),
        "/nav": (_) => const BottomNav(),
      },
    );
  }
}
