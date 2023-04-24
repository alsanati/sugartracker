import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class PulsatingRoundButton extends StatefulWidget {
  const PulsatingRoundButton({super.key});

  @override
  State<PulsatingRoundButton> createState() => _PulsatingRoundButtonState();
}

class _PulsatingRoundButtonState extends State<PulsatingRoundButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _rotationAnimation;
  bool _arrowTapped = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeInOutExpo,
    ));
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTween = ColorTween(
        begin: Colors.transparent, end: Theme.of(context).colorScheme.error);

    return GestureDetector(
      onTap: () {
        setState(() {
          _arrowTapped = true;
        });
        if (_arrowTapped) {
          _animationController!.addListener(() {
            setState(() {});
          });
          context.go("/home");
        }
      },
      child: AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          final Color shadowColor = colorTween.evaluate(_animationController!)!;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: 10.0,
                  spreadRadius: _animationController!.value * 10,
                ),
              ],
            ),
            child: child,
          );
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          child: Transform.rotate(
            angle: _arrowTapped ? _rotationAnimation!.value : 0,
            child: Icon(
              FontAwesomeIcons.arrowRight,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
