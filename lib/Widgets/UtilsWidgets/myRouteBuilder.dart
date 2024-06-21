import 'package:flutter/cupertino.dart';

class MyRouteBuilder {
  Route createRoute(page, double horizontal, double verticale) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        Offset begin = Offset(horizontal, verticale);
        Offset end = Offset.zero;
        Curve curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
