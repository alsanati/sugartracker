// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:sugar_tracker/app/ui/auth/signup_page.dart';
import 'package:sugar_tracker/app/ui/chart_views/chart.dart';
import 'package:sugar_tracker/text_theme.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sugar_tracker/app/ui/auth/account_page.dart';
import 'package:sugar_tracker/app/ui/auth/splash_page.dart';
import 'app/ui/auth/login/login_page.dart';
import 'color_schemes.g.dart';
import 'constants.dart';
import 'app/components/bottomNav.dart';
import 'app/ui/dashboard/homepage.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        debugPrint(state.location);
        return const NoTransitionPage(child: NavigationExample());
      },
      routes: [
        GoRoute(
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: Homepage(),
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
            parentNavigatorKey: _shellNavigatorKey,
            path: '/account',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: AccountPage(),
              );
            }),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/login',
      pageBuilder: (context, state) {
        return NoTransitionPage(key: UniqueKey(), child: const LoginPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/',
      pageBuilder: (context, state) {
        return NoTransitionPage(key: UniqueKey(), child: const SplashPage());
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: '/signup',
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
            key: UniqueKey(),
            child: const SignUpPage(),
            transitionDuration: const Duration(milliseconds: 150),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              // Change the opacity of the screen using a Curve based on the the animation's
              // value
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
                child: child,
              );
            });
      },
    ),
  ],
);

Future<void> main() async {
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Suggra',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: textTheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
    );
  }
}
