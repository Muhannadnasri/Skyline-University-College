import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(CourseAllocation());

class CourseAllocation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseAllocationState();
  }
}

// Map<String, int> body;

class _CourseAllocationState extends State<CourseAllocation> {
  @override
  void initState() {
    super.initState();
    getCourseAllocationData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, 'Course Faculty'),
        body: courseAllocationJson == null
            ? exception(context, FontAwesomeIcons.exclamationTriangle,
                'No course available')
            : Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white,
                          child: DottedBorder(
                            color: Colors.blue,
                            gap: 3,
                            strokeWidth: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  height: 50,
                                  width: 100,
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
                                          ])),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, "/courseAllocationMorning");
                                    },
                                    child: Center(
                                      child: Text(
                                        'Morning',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
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
                                          ])),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              "/courseAllocationEvening");
                                        },
                                        child: Center(
                                            child: Text(
                                          'Evening',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
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
                                          ])),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                              "/courseAllocationWeekend");
                                        },
                                        child: Center(
                                            child: Text(
                                          'Weekend',
                                          style: TextStyle(color: Colors.white),
                                        ))),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: courseAllocationJson.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
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
                                            ])),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            courseAllocationJson[index]
                                                ['Course Description'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text('Course Code : '),
                                      Text(
                                        courseAllocationJson[index]
                                                ['Course Code']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Semester: "),
                                      Text(courseAllocationJson[index]
                                              ['Semester']
                                          .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text("Batch Code: "),
                                      Text(courseAllocationJson[index]
                                              ['Batch Code']
                                          .toString()),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('Program : '.padRight(10)),
                                      Text(
                                        courseAllocationJson[index]['Program']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('Level :'.padRight(10)),
                                      Text(
                                        courseAllocationJson[index]['Level']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('Morning : '),
                                      Text(
                                        courseAllocationJson[index]['Morning']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('Evening : '),
                                      Text(
                                        courseAllocationJson[index]['Evening']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text('Weekend : '),
                                      Text(
                                        courseAllocationJson[index]['Weekend']
                                            .toString(),
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
                    ),
                  ],
                ),
              ));
  }

  Future getCourseAllocationData() async {
    Future.delayed(Duration.zero, () {
      courseAllocationJson = [];
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getCourseAllocationData"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'faculty_id': studentJson['data']['user_id'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          courseAllocationJson = json.decode(response.body)['data']['courses'];
          courseAllocationMorningJson =
              json.decode(response.body)['data']['morning'];
          courseAllocationEveningJson =
              json.decode(response.body)['data']['evening'];
          courseAllocationWeekendJson =
              json.decode(response.body)['data']['weekend'];
        });
      }
      showLoading(false, context);
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourseAllocationData);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourseAllocationData);
      }
    }
  }
}
