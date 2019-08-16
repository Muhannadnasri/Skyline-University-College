import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';

import 'attendanceDetails.dart';

void main() => runApp(Attendance());

class Attendance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AttendanceState();
  }
}

// // Map<String, int> body;

class _AttendanceState extends State<Attendance> {
  List attendanceJson = [];
  Map attendanceMessageJson = {};

  @override
  void initState() {
    super.initState();
    getStudentAttendance();
    attendanceJson = [];
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        key: _scaffoldkey,
        appBar: appBarLogin(context, 'Attendance'),
        body: Container(
          color: Colors.grey[300],
          child: Column(
            children: <Widget>[
              Card(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                studentJson['data']['name'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Roll NO:",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    username,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text('Semester : '),
                                  Text(studentJson['data']['acadyear_desc']),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text("Program: "),
                                  Text(studentJson['data']['program']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: attendanceJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AttendanceDetails(
                              index: index,
                              classSectionID: attendanceJson[index]
                                      ['ClassSectionID']
                                  .toString(),
                              className: attendanceJson[index]
                                      ['Cdd_Description']
                                  .toString(),
                              classBatch:
                                  attendanceJson[index]['BatchCode'].toString(),
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              attendanceJson[index]
                                                  ['Cdd_Description'],
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text('Faculty Name : '),
                                      Expanded(
                                        child: Text(
                                          attendanceJson[index]['FName']
                                              .toString(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Class Absent: "),
                                      Expanded(
                                        child: Text(attendanceJson[index]
                                                        ['NATT']
                                                    .toString() ==
                                                "null"
                                            ? "0"
                                            : attendanceJson[index]['NATT']),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Percentage Absent: "),
                                      Expanded(
                                        child: Text(attendanceJson[index]
                                                        ['NATT']
                                                    .toString() ==
                                                ("null")
                                            ? "0.0"
                                            : attendanceJson[index]['NATT']
                                                        .toString() ==
                                                    ("13.4")
                                                ? "Please go to SSD"
                                                : attendanceJson[index]['NATT']
                                                    .toString()),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          attendanceJson[index]['NATT']
                                                      .toString() ==
                                                  ("4.44")
                                              ? "Please Vist SSD "
                                              : "",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(children: <Widget>[
                                    Text('Batch Code : '.padRight(10)),
                                    Expanded(
                                      child: Text(
                                        attendanceJson[index]['BatchCode']
                                            .toString(),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Future getStudentAttendance() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getStudentAttendance"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'student_id': username,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          attendanceJson = json.decode(response.body)['data'];

          attendanceMessageJson = json.decode(response.body);
        });
//TODO: toast

        print(attendanceJson);

        showLoading(false, context);
      }
      if (attendanceMessageJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: attendanceMessageJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getStudentAttendance);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getStudentAttendance);
      }
    }
  }
}
