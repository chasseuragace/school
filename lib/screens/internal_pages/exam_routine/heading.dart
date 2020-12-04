
import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';

class Heading extends StatelessWidget {
  final List<String> headings;

  const Heading({Key key, this.headings}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
        ...headings.map((e) => Flexible(child: SizedBox(width:  (MediaQuery.of(context).size.width-20)/(headings.length),child: Center(child: Text(e,style: Constants.title.copyWith(fontSize: 16),)))))
      ],),
    );
  }
}
