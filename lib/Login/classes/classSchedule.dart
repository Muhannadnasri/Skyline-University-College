import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
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
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getClassScheduleWeekdayy();
    classScheduleJson = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarLogin(context, '${widget.title}'),
        body: classScheduleJson == null || classScheduleJson.isEmpty
            ? exception(context, isLoading)
            : ListView.builder(
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
                          child: Row(children: <Widget>[
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
                              child: Text('session 1 : ',
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
                                      : classScheduleJson[index]['Ses1']
                                          .toString(),
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
                              child: Text("session 2 : ",
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
                                      : classScheduleJson[index]['Ses2']
                                          .toString(),
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
                              child: Text("session 3 : ",
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
                                      : classScheduleJson[index]['Ses3']
                                          .toString(),
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
                              child: Text('session 4 : ',
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
                                      : classScheduleJson[index]['Ses4']
                                          .toString(),
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
                              child: Text('session 5 : ',
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
                                      : classScheduleJson[index]['Ses5']
                                          .toString(),
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('session 6 : ',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            Expanded(
                              child: Text(
                                  classScheduleJson[index]['Ses6'].toString() ==
                                          "null"
                                      ? ""
                                      : classScheduleJson[index]['Ses6']
                                          .toString(),
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('session 7 : ',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            Expanded(
                              child: Text(
                                  classScheduleJson[index]['Ses7'].toString() ==
                                          "null"
                                      ? ""
                                      : classScheduleJson[index]['Ses7']
                                          .toString(),
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('session 8 : ',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            Expanded(
                              child: Text(
                                  classScheduleJson[index]['Ses8'].toString() ==
                                          "null"
                                      ? ""
                                      : classScheduleJson[index]['Ses8']
                                          .toString(),
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('session 9 : ',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            Expanded(
                              child: Text(
                                  classScheduleJson[index]['Ses9'].toString() ==
                                          "null"
                                      ? ""
                                      : classScheduleJson[index]['Ses9']
                                          .toString(),
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
              ));
  }

  Future getClassScheduleWeekdayy() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.parse("https://skylineportal.com/moappad/api/test/${widget.link}"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          classScheduleJson = json.decode(response.body)['data'];
          classScheduleMessageJson = json.decode(response.body);
          isLoading = false;
        });
        showLoading(false, context);
      }

      // if (classScheduleMessageJson['success'] == '0') {
      //   showLoading(false, context);
      //   Fluttertoast.showToast(
      //       msg: classScheduleMessageJson['message'],
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIos: 1,
      //       backgroundColor: Colors.grey[400],
      //       textColor: Colors.black87,
      //       fontSize: 13.0);
      // }
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
