import 'package:flutter/cupertino.dart';

class PageRouteAnimation extends PageRouteBuilder {
  final Widget widget;
  PageRouteAnimation(this.widget)
      : super(
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (context, Animation<double> animation,
                Animation<double> secAnimation, Widget child) {
              animation = CurvedAnimation(
                  parent: animation, curve: Curves.elasticInOut);
              return ScaleTransition(
                scale: animation,
                alignment: Alignment.bottomCenter,
                child: child,
              );
            },
            pageBuilder: (context, Animation<double> animation,
                Animation<double> secAnimation) {
              return widget;
            });
}
