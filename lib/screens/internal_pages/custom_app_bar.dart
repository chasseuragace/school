import 'package:flutter/material.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

import '../../const.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.tag, @required this. title, this.customAsset,
  }) : super(key: key);

  final String tag;
  final String title;
  // ignore: non_constant_identifier_names
  final String customAsset;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          makeSlideTween(
            context: context,
            child: Row(
              children: [
                Hero(
                  tag: tag,
                  child: applyShade(
                    child: SizedBox(
                      height: 30,
                      width: 40,
                      child: Image.asset(
                        "assets/${customAsset??tag}.png",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Text(
                  title,
                  style: Constants.title.copyWith(fontSize: 20),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}