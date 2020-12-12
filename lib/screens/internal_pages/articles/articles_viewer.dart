import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/screens/navigation_wrapper/material_notification.dart';

class ArticleViewer extends StatelessWidget {
  final MaterialNotification child;

  const ArticleViewer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.tilesColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              tag: child.id.toString(),
              title: child.title,
              customAsset: 'article',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: child,
              ),
            )
          ],
        ),
      ),
    );
  }
}
