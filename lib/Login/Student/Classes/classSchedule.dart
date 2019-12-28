import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';

class ClassSchedule extends StatefulWidget {
  final String link;
  final String title;
  const ClassSchedule({Key key, this.link, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ClassScheduleState();
  }
}

// Map<String, int> body;

class _ClassScheduleState extends State<ClassSchedule> {
  List classScheduleJson = [];
  Map classScheduleMessageJson = {};
  @override
  void initState() {
    super.initState();
    getClassScheduleWeekdayy();
    classScheduleJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, '${widget.title}'),
        body: Container(
          child: ListView.builder(
            itemCount: classScheduleJson.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                              ),
                      ),
                      child: 
                      Row(
                        children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            classScheduleJson[index]['Day'],
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
                          child: Text('section 1 : ',
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Expanded(
                          child: Text(
                              classScheduleJson[index]['Ses1'].toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleJson[index]['Ses1'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
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
                          child: Text("section 2 : ",
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Expanded(
                          child: Text(
                              classScheduleJson[index]['Ses2'].toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleJson[index]['Ses2'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
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
                          child: Text("section 3 : ",
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Expanded(
                          child: Text(
                              classScheduleJson[index]['Ses3'].toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleJson[index]['Ses3'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
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
                          child: Text('section 4 : ',
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Expanded(
                          child: Text(
                              classScheduleJson[index]['Ses4'].toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleJson[index]['Ses4'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
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
                          child: Text('section 5 : ',
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Expanded(
                          child: Text(
                              classScheduleJson[index]['Ses5'].toString() ==
                                      "null"
                                  ? ""
                                  : classScheduleJson[index]['Ses5'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Future getClassScheduleWeekdayy() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/${widget.link}"),
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
          classScheduleJson = json.decode(response.body)['data'];
          classScheduleMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
      }

      if (classScheduleMessageJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: classScheduleMessageJson['message'],
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
            context, getClassScheduleWeekdayy);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getClassScheduleWeekdayy);
      }
    }
  }
}
