// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_quickstart/app/pages/account_page.dart';
import 'package:supabase_quickstart/app/pages/login_page.dart';
import 'package:supabase_quickstart/app/pages/splash_page.dart';

import 'app/components/bottomNav.dart';
import 'app/pages/homepage.dart';
import 'app/pages/signup_page.dart';
import 'constants.dart';

Future<void> main() async {
  await Supabase.initialize(
    // TODO: Replace credentials with your own
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
        '/': (_) => const SplashPage(),
        'login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        "/home": (_) => const Homepage(),
        "/signup": (_) => const SignUpPage(),
        "/nav": (_) => const BottomNav(),
      },
    );
  }
}
