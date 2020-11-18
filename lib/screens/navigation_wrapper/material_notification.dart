import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/simple_utils/date_formatter.dart';
import '../../const.dart';

class MaterialNotification extends StatelessWidget {

  final List<String> image;
  final String title;
  final String content;
  final String signedBy;
  final String date;
  final bool compact;
  const MaterialNotification({
    Key key, this.image,
    this.title="No new notice",
    this.content="Dear Parents and Students,"
        " Greetings of the day. I hope the message finds you "
        " Greetings of the day. I hope the message finds you "
        " Greetings of the day. I hope the message finds you "
        " Greetings of the day. I hope the message finds you "
        " Greetings of the day. I hope the message finds you "
        " Greetings of the day. I hope the message finds you "
        " Greetings of the day. I hope the message finds you "
        " Greetings of the day. I hope the message finds you "
        "in good health and among family"
        " members amidst the Lockdown. Let's be ...",
    this.signedBy="Xabi Lal Gautam",
    this.date="Nov 27, 2020", this.compact=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Constants.tilesColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            /* onTap: (){
                        //todo open notification alert box if has body
                      },*/
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w800),),
                if(image!=null) ...[
                  SizedBox(height: 5,),
                  SizedBox(height: 200,width:  MediaQuery.of(context).size.width,
                child: image.length>1? _buildSlider(context): Image.asset("assets/intro3.png",fit: BoxFit.contain,),
                )]
              ],
            ),
            subtitle: content!=null?Text(
              content,
              textAlign: TextAlign.justify,maxLines: compact?4:26 ,overflow: TextOverflow.ellipsis,
            ):null,
          ),
         Text(
            "-$signedBy",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
         if(date!='') Text(
            DateTime.now().standard(),
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }

  _buildSlider(context) {
    final len =image.length;
final _pageNotifier =ValueNotifier<int>(0);
    final _pc =PageController();
    _pc.addListener(() {
      _pageNotifier.value=_pc.page.round();
    });
    return Column(
      children: [
        Expanded(
          flex:1,
          child: PageView(
            controller: _pc,
            children: [
             ... image.map((e) => Image.asset("assets/intro1.png"))
            ],
          ),
        ),
        ValueListenableBuilder<int>(
          valueListenable:  _pageNotifier,
          builder: (context, v,child) {
            return Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              for(int i=0;i<len;i++)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(radius: 3,backgroundColor: v==i?Constants.lightAccent:Colors.grey,),
                )

            ],);
          }
        )
      ],
    );
  }
}
