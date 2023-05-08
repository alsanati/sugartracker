// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sugar_tracker/app/features/components/bottom_nav.dart';
import 'package:sugar_tracker/app/features/dashboard/components/get_sugar_data.dart';

import 'package:sugar_tracker/text_theme.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/features/auth/account_page.dart';
import 'app/features/auth/login/login_page.dart';
import 'app/features/auth/signup/signup_page.dart';
import 'app/features/auth/signup/stepper_form_page.dart';
import 'app/features/auth/splash_page.dart';
import 'app/features/charts/chart.dart';
import 'app/features/dashboard/dashboard_views/homepage.dart';
import 'app/utils/color_schemes.g.dart';
import 'app/utils/constants.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required WidgetBuilder builder})
      : super(
          builder: builder,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = const Offset(1.0, 0.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return CustomBottomNavigationBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                  key: UniqueKey(), child: const SplashPage());
            },
          ),
          GoRoute(
            path: '/dashboard',
            pageBuilder: (context, state) {
              return const MaterialPage(child: Chart());
            },
          ),
          GoRoute(
              path: '/account',
              pageBuilder: (context, state) {
                return const MaterialPage(
                  child: AccountPage(),
                );
              }),
          GoRoute(
              path: '/home',
              pageBuilder: (context, state) {
                return const MaterialPage(
                  child: Homepage(),
                );
              },
              routes: [
                GoRoute(
                  path: 'sugarlevels',
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage<void>(
                        key: UniqueKey(),
                        child: const PostSugarLevels(),
                        transitionDuration: const Duration(milliseconds: 150),
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          // Change the opacity of the screen using a Curve based on the the animation's
                          const begin = Offset(0.0, 2.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        });
                  },
                ),
              ]),
        ]),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return MaterialPage(key: UniqueKey(), child: const LoginPage());
      },
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: UniqueKey(),
          child: const SignUpPage(),
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
        path: '/stepper',
        pageBuilder: (context, state) {
          return const MaterialPage(
            child: StepperPage(),
          );
        }),
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
