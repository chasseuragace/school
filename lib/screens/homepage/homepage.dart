import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("Welcome Parents"),
          Builder(builder: (
            context,
          ) {
            var name = "Hari Lal Purna Gautam";
            var attributes = {
              "DOB":"January 27, 2008",
              "Class": "Six",
              "Section": "Stone Cold",
              "Rank": "12",
            };
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 2,
                color: Colors.grey[200],
               borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Container(
                        width:  (MediaQuery.of(context).size.width-16)/3,
                        color:Colors.white38,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Material(
                              elevation: 1,
                              color: Constants.lightAccent.withOpacity(.3),
                              borderRadius: BorderRadius.circular(45),
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Image.asset(
                                      "assets/intro2.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Flexible(
                              child: Text(
                                "$name",textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: Constants.title.copyWith(fontSize: 16,color: Colors.black87,),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 6,),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ...attributes.keys
                                  .map((e) => Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: 16,
                                                    color: Colors.black54,
                                                    letterSpacing: 1),
                                              )),
                                          Expanded(
                                              flex: 1, child: Text(attributes[e],style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              letterSpacing: 1))),
                                        ],
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
