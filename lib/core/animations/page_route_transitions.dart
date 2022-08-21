import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

const int defaultDuration = 500;

// A helper class that defines a few custom material motion page route
// transitions
class PageRouteTransitions {
  static Route<T> fadeThrough<T>(
    Widget page, [
    int duration = defaultDuration,
  ]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child);
      },
    );
  }

  static Route<T> fadeScale<T>(
    Widget page, [
    int duration = defaultDuration,
  ]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }

  static Route<T> sharedAxis<T>(
    Widget page, [
    SharedAxisTransitionType type = SharedAxisTransitionType.scaled,
    int duration = defaultDuration,
  ]) {
    return PageRouteBuilder<T>(
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: type,
          child: child,
        );
      },
    );
  }
}
