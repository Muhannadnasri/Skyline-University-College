import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
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
        body: assessmentMarkCoursesJson == null ||
                assessmentMarkCoursesJson.isEmpty
            ? exception(context)
            : Container(
                child: ListView.builder(
                  itemCount: assessmentMarkCoursesJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AssessmentMarks(
                                classID: assessmentMarkCoursesJson[index]['cid']
                                    .toString()),
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
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: new BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
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
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            assessmentMarkCoursesJson[index]
                                                ['cname'],
                                            style: TextStyle(
                                                color: isDark(context)
                                                    ? Colors.white
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: <Widget>[
                                    Text('Faculty Name : ',
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black)),
                                    Expanded(
                                      child: Text(
                                          assessmentMarkCoursesJson[index]
                                                  ['staff_name']
                                              .toString(),
                                          style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Batch Code : ",
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black)),
                                    Expanded(
                                      child: Text(
                                          assessmentMarkCoursesJson[index]
                                                  ['cid']
                                              .toString(),
                                          style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(children: <Widget>[
                                  Text("Semester  : ",
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black)),
                                  Expanded(
                                    child: Text(
                                        assessmentMarkCoursesJson[index]
                                                ['SemesterName']
                                            .toString(),
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black)),
                                  ),
                                ]),
                              ),
                            ],
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
            "https://skylineportal.com/moappad/api/test/assessmentMarkCourses"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          assessmentMarkCoursesJson = json.decode(response.body)['data'];
        });
        showLoading(false, context);
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
