import 'package:flutter/material.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

import '../../const.dart';

class DashBoardTile extends StatelessWidget {
  final tileTitle, assetImage;
  const DashBoardTile({
    Key key, @required this.assetImage, @required this.tileTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(6),
      color: Color(0xfff8f8f8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
            //todo when changing shades to icon use applyShade()
            applyShade(
              child: SizedBox(
                  width: 35,
                  height: 35,
                  child: Image.asset(
                    "assets/$assetImage.png",
                    fit: BoxFit.cover,
                    color: Colors.white,
                  )),
            ),
            // child: Icon(Icons.exam),
          ),
          Flexible(
            child: Text(
              tileTitle,
              style: Constants.title.copyWith(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
