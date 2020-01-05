import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:transparent_image/transparent_image.dart';

import 'listscontent.dart';

class Lists extends StatefulWidget {
  final String title;
  final String value;

  const Lists({Key key, this.title, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListsState();
  }
}

List lists = [];

File dataFile;

Map<String, String> body;
Map eventsJson = {};

class _ListsState extends State<Lists> {
  @override
  void initState() {
    super.initState();
    lists = [];
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, '${widget.title}'),
      body: lists == null
          ? exception(context)
          : Container(
              child: ListView.builder(
                  itemCount: lists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListsContent(
                              contentTitle: lists[index]['title'],
                              contentContent: lists[index]['content'],
                              contentImage: lists[index]['image_big'],
                              contentDate: lists[index]['date'],
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 10,
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
                                        tag: lists[index]['image_big'],
                                        child: Center(
                                          child: FadeInImage.memoryNetwork(
                                            image: lists[index]['image_big'],
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
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          gradient: isDark(context)
                                              ? LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Color(0xFF1F1F1F),
                                                    Color(0xFF1F1F1F),
                                                  ],
                                                  stops: [
                                                    0.7,
                                                    0.9,
                                                  ],
                                                )
                                              : LinearGradient(
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
                                                )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(children: <Widget>[
                                          Icon(
                                            FontAwesomeIcons.calendarDay,
                                            size: 10,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            lists[index]['date'],
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white),
                                          )
                                        ]),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: Text(
                                        lists[index]['title'],
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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

        if (Json['events'] != null) {
          eventsJson = Json;
        } else {
          eventsJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false, context);

        setState(() {
          lists = eventsJson['${widget.value}'];
        });
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        // showErrorServer(context, getEvents());
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getEvents());
      }
    }
  }
}
