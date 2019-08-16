import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';

import 'assessmentMarks.dart';

void main() => runApp(AssessmentMarkCourses());

class AssessmentMarkCourses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AssessmentMarkCoursesState();
  }
}

// Map<String, int> body;

class _AssessmentMarkCoursesState extends State<AssessmentMarkCourses> {
  Map assessmentMarkCoursesJsonMessage = {};
  List assessmentMarkCoursesJson = [];
  @override
  void initState() {
    super.initState();
    getStudentAssessmentMarkCourses();
    assessmentMarkCoursesJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, 'Assessment Courses'),
        body: Container(
          color: Colors.grey[300],
          child: ListView.builder(
            itemCount: assessmentMarkCoursesJson.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssessmentMarks(
                          index: index,
                          classID: assessmentMarkCoursesJson[index]['cid']
                              .toString()),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
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
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        assessmentMarkCoursesJson[index]
                                            ['cname'],
                                        style: TextStyle(color: Colors.white),
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
                                    assessmentMarkCoursesJson[index]
                                            ['staff_name']
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
                                Text("Batch Code : "),
                                Expanded(
                                  child: Text(assessmentMarkCoursesJson[index]
                                          ['cid']
                                      .toString()),
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
                              Text("Semester  : ".padRight(10)),
                              Expanded(
                                child: Text(
                                  assessmentMarkCoursesJson[index]
                                          ['SemesterName']
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
        ));
  }

  Future getStudentAssessmentMarkCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/assessmentMarkCourses"),
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
          assessmentMarkCoursesJson = json.decode(response.body)['data'];
          assessmentMarkCoursesJsonMessage = json.decode(response.body);
        });
        showLoading(false, context);
      }
      if (assessmentMarkCoursesJsonMessage['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: assessmentMarkCoursesJsonMessage['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getStudentAssessmentMarkCourses);
      } else {
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getStudentAssessmentMarkCourses);
      }
    }
  }
}
