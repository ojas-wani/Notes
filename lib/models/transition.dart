import 'package:flutter/material.dart';

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0.0;
      var end = 1.0;
      var curve = Curves.slowMiddle;

      var tween = Tween(begin: begin, end: end)
          .animate(CurvedAnimation(curve: curve, parent: animation));

      return ScaleTransition(
        scale: tween,
        child: child,
      );
    },
  );
}
