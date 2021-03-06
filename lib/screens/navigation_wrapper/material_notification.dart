import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../const.dart';

class MaterialNotification extends StatelessWidget {
  final bool focused;
  final String useHero;
  final bool asArticle;
  final List<String> image;
  final String title;
  final id;
  final bool alert;
  final String content;
  final Function(dynamic) onTap;
  final String signedBy;
  final String date;
  final bool compact;
  final bool asProject;

  const MaterialNotification.deadline(
      {Key key,
      this.image,
      this.title = "Notice",
      this.content = "",
      this.signedBy = "Deadline",
      this.date = "",
      this.focused = false,
      this.compact = false,
      this.onTap,
      this.id,
      this.alert = false,
      this.asArticle = false,
      this.useHero,
      this.asProject = true})
      : super(key: key);

  const MaterialNotification({
    Key key,
    this.image,
    this.title = "Notice",
    this.content = "",
    this.signedBy = "The notice board",
    this.date = "",
    this.focused = false,
    this.compact = false,
    this.onTap,
    this.id,
    this.alert = false,
    this.asArticle = false,
    this.useHero,
    this.asProject = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildMaterial(context);
  }

  Material buildMaterial(BuildContext context) {
    return Material(
      elevation: focused ? 3 : 0,
      color: alert ? Colors.red.withOpacity(.1) : Constants.tilesColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            onTap: onTap == null
                ? null
                : () {
                    //todo open notification alert box if has body
                    onTap(id);
                  },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                useHero != null
                    ? Hero(
                        tag: useHero,
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ))
                    : Text(
                        title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                if (image != null) ...[
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: image.length > 1
                        ? _buildSlider(context)
                        : Image.asset(
                            "assets/intro3.png",
                            fit: BoxFit.contain,
                          ),
                  )
                ]
              ],
            ),
            subtitle: content != null
                ? Text(
                    content,
                    textAlign: TextAlign.justify,
                    maxLines: (compact)
                        ? 4
                        : asArticle
                            ? 700
                            : 26,
                    overflow: TextOverflow.ellipsis,
                    style: asArticle ? TextStyle(fontSize: 16) : null,
                  )
                : null,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${asProject ? '-' : ''}$signedBy",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildSlider(context) {
    final len = image.length;
    final _pageNotifier = ValueNotifier<int>(0);
    final _pc = PageController();
    _pc.addListener(() {
      _pageNotifier.value = _pc.page.round();
    });
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: PageView(
            controller: _pc,
            children: [
              ... image.map((e) => Image.asset("assets/intro1.png"))
            ],
          ),
        ),
        ValueListenableBuilder<int>(
            valueListenable: _pageNotifier,
            builder: (context, v, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center, children: [
                for(int i = 0; i < len; i++)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(radius: 3,
                      backgroundColor: v == i ? Constants.lightAccent : Colors
                          .grey,),
                  )

              ],);
            }
        )
      ],
    );
  }
}
