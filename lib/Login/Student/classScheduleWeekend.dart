import 'package:dotted_border/dotted_border.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;

void main() => runApp(ClassScheduleWeekend());

class ClassScheduleWeekend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClassScheduleWeekendState();
  }
}

// Map<String, int> body;

class _ClassScheduleWeekendState extends State<ClassScheduleWeekend> {
  List classScheduleWeekendJson = [];
  Map classScheduleWeekendMessageJson = {};

  @override
  void initState() {
    super.initState();
    getClassScheduleWeekend();
    classScheduleWeekendJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
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
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Back',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Class Schedule WeekEnd",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: GestureDetector(
                        onTap: () {
                          logOut(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.powerOff,
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Logout',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //TODO: Put all Icon Container
            ],
          ),
        ),
        body: Container(
          color: Colors.grey[300],
          child: ListView.builder(
            itemCount: classScheduleWeekendJson.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 10,
                child: DottedBorder(
                  color: Colors.blue,
                  gap: 3,
                  strokeWidth: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 30,
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        child: Row(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              classScheduleWeekendJson[index]['Day'],
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('section 1 : '),
                          ),
                          Expanded(
                            child: Text(
                              classScheduleWeekendJson[index]['Ses1']
                                          .toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleWeekendJson[index]['Ses1']
                                      .toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("section 2 : "),
                          ),
                          Expanded(
                            child: Text(
                              classScheduleWeekendJson[index]['Ses2']
                                          .toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleWeekendJson[index]['Ses2']
                                      .toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("section 3 : "),
                          ),
                          Expanded(
                            child: Text(
                              classScheduleWeekendJson[index]['Ses3']
                                          .toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleWeekendJson[index]['Ses3']
                                      .toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('section 4 : '.padRight(10)),
                          ),
                          Expanded(
                            child: Text(
                              classScheduleWeekendJson[index]['Ses4']
                                          .toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleWeekendJson[index]['Ses4']
                                      .toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('section 5 : '.padRight(10)),
                          ),
                          Expanded(
                            child: Text(
                              classScheduleWeekendJson[index]['Ses5']
                                          .toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleWeekendJson[index]['Ses5']
                                      .toString(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  Future getClassScheduleWeekend() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/classScheduleWeekend"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          classScheduleWeekendJson = json.decode(response.body)['data'];
          classScheduleWeekendMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
      if (classScheduleWeekendMessageJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: classScheduleWeekendMessageJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getClassScheduleWeekend);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getClassScheduleWeekend);
      }
    }
  }
}
