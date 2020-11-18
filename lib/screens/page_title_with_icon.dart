import 'package:flutter/material.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

import '../const.dart';

class PageTitleWithIcon extends StatelessWidget {
  final String title;
  final Widget icon;
  const PageTitleWithIcon({
    Key key, this.title, this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TweenAnimationBuilder(
          curve: Curves.elasticOut,
          duration: Duration(milliseconds: 900),
          tween: Tween<double>(
              begin: -(22 / 7) / 180 * 25, end: (22 / 7) / 180 * 0),
          builder: (BuildContext context, double value, Widget child) {
            return Transform.rotate(
              angle: value,
              child: child,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: applyShade(
                child: icon),
          ),
        ),
        Text(
          title,
          style: Constants.title,
        ),
      ],
    );
  }
}
