import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';

extension NavigationHelper on BuildContext {
  static const String homePage = '/home';
  static const String settingsPage = '/settings';
  static const String stepperPage = '/stepper';

  void go(String page) {
    GoRouter.of(this).go(page);
  }
}

class RiveTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const RiveTransition(
      {super.key, required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        // Use the animation value to control the Rive animation progress
        // You can replace 'animationName' with the name of your Rive animation
        return const RiveAnimation.network(
          '../assets/4188-9638-jump-on-the-trampoline.riv',
          fit: BoxFit.cover,
        );
      },
    );
  }
}
