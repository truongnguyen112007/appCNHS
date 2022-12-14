import 'package:flutter/cupertino.dart';

class NavigatorUtils {
  static void pop(BuildContext context, dynamic result) =>
      Navigator.pop(context, result);


  static Future<dynamic> moveBottomToTop(
      Widget page, BuildContext context) async =>
      await Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
  static dynamic newPage(Widget newPage, BuildContext context) async {
    return Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => newPage,
    ));
  }
}
