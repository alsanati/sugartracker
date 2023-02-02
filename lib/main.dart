// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/views/chart_views/chart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sugar_tracker/app/views/account_views/account_page.dart';
import 'package:sugar_tracker/app/views/account_views/login_page.dart';
import 'package:sugar_tracker/app/views/account_views/splash_page.dart';

import 'app/components/bottomNav.dart';
import 'app/views/homepage.dart';
import 'app/views/account_views/signup_page.dart';
import 'constants.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        print(state.location);
        return NoTransitionPage(
            child: ScaffoldWithNavBar(
          location: state.location,
          child: child,
        ));
      },
      routes: [
        GoRoute(
          path: '/login',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: LoginPage());
          },
        ),
        GoRoute(
          path: '/',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: Homepage()),
              ),
            );
          },
        ),
        GoRoute(
          path: '/splash',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: SplashPage()),
              ),
            );
          },
        ),
        GoRoute(
          path: '/dashboard',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: Chart()),
              ),
            );
          },
        ),
        GoRoute(
          path: '/account',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Scaffold(
                body: Center(child: AccountPage()),
              ),
            );
          },
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: UniqueKey(),
          child: const LoginPage(),
        );
      },
    ),
  ],
);

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
    return MaterialApp.router(
      routerConfig: router,
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
    );
  }
}
