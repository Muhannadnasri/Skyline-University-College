import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(CourseWithdrawal());

class CourseWithdrawal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseWithdrawalState();
  }
}

final _remarkCourse = GlobalKey<FormState>();

// Map<String, int> body;

class _CourseWithdrawalState extends State<CourseWithdrawal> {
  Map courseWithdrawalJson = {};
  Map courseNameJson = {};
  List courseWithdrawalCoursesJson = [];
  bool isLoading = true;
  String remarkCourse = '';
  bool checkValue = false;
  int groupValue;
  String id;

  @override
  void initState() {
    super.initState();
    getCourseWithdrawalCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: courseWithdrawalCoursesJson == null ||
              courseWithdrawalCoursesJson.isEmpty
          ? SizedBox()
          : bottomappBar(
              context,
              () {
                setState(() {
                  if (_remarkCourse.currentState.validate() && id != null) {
                    _remarkCourse.currentState.save();
                    return sendCourseWithdrawal();
                  } else {
                    checkValue = true;
                  }
                  return null;
                });
              },
            ),
      appBar: appBarLogin(context, 'Course Withdrawal'),
      body: courseWithdrawalCoursesJson == null ||
              courseWithdrawalCoursesJson.isEmpty
          ? exception(context, isLoading)
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      dropDownWidget(
                        context,
                        'Select Option',
                        id,
                        courseWithdrawalCoursesJson,
                        'CDD_ID',
                        'Cdd_COde',
                        (value) {
                          setState(() {
                            id = value;
                            getCourseName();
                          });
                        },
                        'Course Code',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Course Title',
                              style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5),
                        child: Container(
                          height: 50,
                          decoration: new BoxDecoration(
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
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Center(
                              child: Text(
                                courseNameJson.isEmpty
                                    ? 'Please Select Course Code'
                                    : courseNameJson['data']['CourseName'],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Form(
                            key: _remarkCourse,
                            child: globalForms(
                              context,
                              '',
                              (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Your reason is required';
                                }
                                return null;
                              },
                              (x) {
                                setState(() {
                                  remarkCourse = x;
                                });
                              },
                              'Reason',
                              TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future getCourseWithdrawalCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/CourseWithdrawalCourses'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            courseWithdrawalCoursesJson = json.decode(response.body)['data'];
            isLoading = false;
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourseWithdrawalCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourseWithdrawalCourses);
      }
    }
  }

  Future getCourseName() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse('https://skylineportal.com/moappad/api/test/CourseName'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'course_id': id,
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            courseNameJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourseWithdrawalCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourseWithdrawalCourses);
      }
    }
  }

  Future sendCourseWithdrawal() async {
    if (_remarkCourse.currentState.validate()) {
      _remarkCourse.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/courseWithdrawal'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'courseCode': id,
          'courseTitle': courseNameJson['data']['CourseName'],
          'Remarks': remarkCourse,
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            courseWithdrawalJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
      if (courseWithdrawalJson['success'] == '0') {
        showfailureSnackBar(context, courseWithdrawalJson['message']);
      }
      if (courseWithdrawalJson['success'] == '1') {
        showSuccessSnackBar(context, courseWithdrawalJson['message']);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourseWithdrawalCourses);
      } else {
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourseWithdrawalCourses);

        showLoading(false, context);
      }
    }
  }
}
