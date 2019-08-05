import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(AttendanceDetails());

class AttendanceDetails extends StatefulWidget {
  final String classSectionID;
  final String className;
  final int index;
  final String classBatch;

  const AttendanceDetails(
      {Key key,
      this.classSectionID,
      this.className,
      this.index,
      this.classBatch})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AttendanceDetailsState();
  }
}

// Map<String, int> body;

class _AttendanceDetailsState extends State<AttendanceDetails> {
  List attendanceDetailsJson = [];

  Map attendanceDetailsJsonMessage = {};
  @override
  void initState() {
    super.initState();
    getStudentAttendanceDetails();
    attendanceDetailsJson = [];
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
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Attendance Details",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
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
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                        ],
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
      body: Column(
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
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
//
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text('Batch Code:' +
                              '  ' +
                              widget.classBatch.toString()),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attendanceDetailsJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      DottedBorder(
                        color: Colors.blue,
                        gap: 3,
                        strokeWidth: 1,
                        child: Container(
                          height: 50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.calendarDay,
                                          size: 17,
                                          color: Colors.purple,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(attendanceDetailsJson[index]
                                                ['Attendance Taken On']
                                            .toString()),
                                      ],
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          attendanceDetailsJson[index]
                                                      ['Attendance'] ==
                                                  "ABSENT".toString()
                                              ? Icon(
                                                  FontAwesomeIcons.solidCircle,
                                                  color: Colors.red,
                                                  size: 13,
                                                )
                                              : attendanceDetailsJson[index]
                                                          ['Attendance'] ==
                                                      "PRESENT".toString()
                                                  ? Icon(
                                                      FontAwesomeIcons
                                                          .solidCircle,
                                                      color: Colors.green,
                                                      size: 13,
                                                    )
                                                  : SizedBox(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          attendanceDetailsJson[index]
                                                      ['Attendance'] ==
                                                  "ABSENT".toString()
                                              ? Text(
                                                  'Absent',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                )
                                              : attendanceDetailsJson[index]
                                                          ['Attendance'] ==
                                                      "PRESENT".toString()
                                                  ? Text(
                                                      'Present',
                                                      style: TextStyle(
                                                          color: Colors.green),
                                                    )
                                                  : SizedBox()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future getStudentAttendanceDetails() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getStudentAttendanceDetails"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'student_id': username,
          'class_section_id': widget.classSectionID,
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          attendanceDetailsJson = json.decode(response.body)['data'];
          attendanceDetailsJsonMessage = json.decode(response.body);
        });

        print(widget.classSectionID);
        showLoading(false, context);
      }
      if (attendanceDetailsJsonMessage['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: attendanceDetailsJsonMessage['message'],
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
            context, getStudentAttendanceDetails);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getStudentAttendanceDetails);
      }
    }
  }
}
