import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/Events/oneEvent.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(Events());

class Events extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventsState();
  }
}

List events = [];

File dataFile;

Map<String, String> body;
Map eventsJson = {};

class _EventsState extends State<Events> {
  @override
  void initState() {
    super.initState();
    events = [];
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    double c_width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Events'),
      body: events == null
          ? exception(context, FontAwesomeIcons.exclamationTriangle,
              'No events available')
          : Container(
              color: Colors.grey[300],
              child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OneEvents(
                              oneEventsTitle: events[index]['title'],
                              oneEventsContent: events[index]['content'],
                              oneEventsImage: events[index]['image_big'],
                              oneEventsDate: events[index]['date'],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 10,
                          child: DottedBorder(
                            color: Colors.blue,
                            gap: 3,
                            strokeWidth: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: SpinKitRing(
                                            size: 35,
                                            lineWidth: 2,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        Hero(
                                          tag: events[index]['image_big'],
                                          child: Center(
                                            child: FadeInImage.memoryNetwork(
                                              image: events[index]['image_big'],
                                              fit: BoxFit.contain,
                                              placeholder: kTransparentImage,
                                              height: 80,
                                              width: 100,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Hero(

                                //     tag: events[index]['image_big'],
                                //     child: Center(
                                //       child: FadeInImage.memoryNetwork(
                                //         fit: BoxFit.contain,
                                //         placeholder: kTransparentImage,
                                //         image: events[index]['image_big'],
                                //         height: 80,
                                //         width: 100,
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 20,
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF104C90),
                                              Color(0xFF3773AC),
                                            ],
                                            stops: [
                                              0.7,
                                              0.9,
                                            ],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(children: <Widget>[
                                            Icon(
                                              Icons.update,
                                              size: 10,
                                              color: Colors.white,
                                            ),
                                            Text(
                                              events[index]['date'],
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            )
                                          ]),
                                        ),
                                      ),
//                    /TODO: Date
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: c_width,
                                        child: Text(
                                          events[index]['title'],
                                          textAlign: TextAlign.left,
                                        ),
                                      ), //TODO: Title
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }

  Future getEvents() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    body = {};
    try {
      http.Response response = await http.post(
          "http://www.muhannadnasri.com/App/news_events/data.json",
          body: body);

      if (response.statusCode == 200) {
        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['events'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }

        if (Json['events'] != null) {
          eventsJson = Json;
        } else {
          eventsJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false, context);

        setState(() {
          events = eventsJson["events"];
        });
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getEvents);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getEvents);
      }
    }
  }
}
