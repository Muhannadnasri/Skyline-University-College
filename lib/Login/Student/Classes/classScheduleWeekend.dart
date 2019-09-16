import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';

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
        appBar: appBarLogin(context, 'Class Schedule WeekEnd'),
        body: Container(
          color: Colors.white,
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
          'usertype': studentJson['data']['user_type'],
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
