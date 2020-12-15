import 'package:flutter/material.dart';
import 'package:schoolapp/const.dart';
import 'package:schoolapp/screens/internal_pages/custom_app_bar.dart';
import 'package:schoolapp/simple_utils/widgets.dart';

class BusDetails extends StatelessWidget {
  generateBusDetails() {
    return {
      "main": {
        'name': 'Bus No. 3',
        'time': "9:33 AM",
        'stops': [
          "yo thau",
          "tyo  thau",
          "aarko thau",
          "aali aaghadi thau",
          "school xeu ko thau",
          "school ",
        ],
        'my_stop': 'aali aaghadi thau'
      },
      'bus_details': [
        {
          'name': 'Bus No. 1',
          'stops': [
            "yo thau",
            "tyo  thau",
            "aarko thau",
            "aali aaghadi thau",
            "school xeu ko thau",
            "school ",
          ]
        },
        {
          'name': 'Bus No. 2',
          'stops': [
            "yo thau",
            "tyo  thau",
            "aarko thau",
            "aali aaghadi thau",
            "school xeu ko thau",
            "school ",
          ]
        },
        {
          'name': 'Bus No. 3',
          'stops': [
            "yo thau",
            "tyo  thau",
            "aarko thau",
            "aali aaghadi thau",
            "school xeu ko thau",
            "school ",
          ]
        },
        {
          'name': 'Bus No. 4',
          'stops': [
            "yo thau",
            "tyo  thau",
            "aarko thau",
            "aali aaghadi thau",
            "school xeu ko thau",
            "school ",
          ]
        },
      ]
    };
  }

  static const String tag = "bus";

  @override
  Widget build(BuildContext context) {
    var busDetails = generateBusDetails();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Bus Details",
              tag: tag,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (c) => BusStops(
                            myStop: busDetails['main']['my_stop'],
                            name: busDetails['main']['name'],
                            stops: busDetails['main']['stops'],
                          )),
                );
              },
              leading: applyShade(
                  child: Icon(
                Icons.bus_alert,
                color: Colors.white,
              )),
              tileColor: Constants.lightAccent.withOpacity(.1),
              title: Text('${busDetails['main']['name']}'),
              subtitle: Text('${busDetails['main']['time']}'),
              trailing: Icon(
                Icons.star,
                color: Colors.yellow,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: busDetails['bus_details'].length,
                itemBuilder: (BuildContext context, int index) {
                  var tag =
                      '${busDetails['bus_details'][index]['name']}_${UniqueKey()}';
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Hero(
                      tag: tag,
                      child: Material(
                        color: Colors.transparent,
                        child: ListTile(
                          leading: applyShade(
                              child: Icon(
                            Icons.bus_alert,
                            color: Colors.white,
                          )),
                          tileColor: Constants.tilesColor,
                          title: Text(
                              '${busDetails['bus_details'][index]['name']}'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (c) => BusStops(
                                      name: tag,
                                      stops: busDetails['bus_details'][index]
                                          ['stops'],
                                    )));
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BusStops extends StatelessWidget {
  final List<String> stops;
  final String name;
  final String myStop;

  const BusStops({Key key, this.stops, this.name, this.myStop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              tag: name,
              title: 'Bus Stops - ${name.split('_')[0]}',
              customAsset: 'bus',
            ),
            Expanded(
              child: ListView(
                children: [
                  ...stops.map((e) => Container(
                        height: 80,
                        child: Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 50,
                              child: Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.black54,
                                  child: applyShade(
                                      child: Icon(
                                    Icons.directions_bus,
                                    size: 20,
                                    color: Colors.white,
                                  )),
                                  height: 80,
                                  width: 25,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                tileColor: myStop == e
                                    ? Constants.lightAccent.withOpacity(.1)
                                    : null,
                                title: Text(e),
                                subtitle: Text(myStop == e ? 'My stop' : ''),
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
