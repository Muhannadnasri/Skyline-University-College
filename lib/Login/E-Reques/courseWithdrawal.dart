import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

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

  String remarkCourse = '';

  int groupValue;
  String id;

  @override
  void initState() {
    super.initState();
    getCourseWithdrawalCourses();
    courseNameJson.clear();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBarLogin(context, 'Course Withdrawal'),
      body: Container(
        color: Colors.grey[300],
        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Course Code',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          hint: Text(
                            'Select Option',
                            style: TextStyle(color: Colors.black),
                          ),
                          isExpanded: true,
                          value: id,
                          items: courseWithdrawalCoursesJson
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item['CDD_ID'].toString(),
                                      child: Text(item['Cdd_COde']),
                                    ),
                                  )
                                  ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              id = value;
                              print(id);
                              getCourseName();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Course Title',
                          style: TextStyle(color: Colors.grey[600]),
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
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Center(
                          child: Text(
                            courseNameJson.isEmpty
                                ? ''
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
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _remarkCourse,
                        onChanged: () {
                          if (_remarkCourse.currentState.validate()) {
                            isValidat = true;
                            return 'Please check your input';
                          } else {
                            isValidat = false;
                            return null;
                          }
                        },
                        child: GlobalForms(
                          context,
                          "Please enter you'r reason",
                          '',
                          isValidat
                              ? FontAwesomeIcons.checkCircle
                              : !isValidat
                                  ? FontAwesomeIcons.timesCircle
                                  : null,
                          isValidat
                              ? Colors.green
                              : !isValidat ? Colors.red : null,
                          (String value) {
                            if (value.length < 3 ||
                                value.isEmpty ||
                                remarkCourse == null) {
                              isValidat = false;
                              return 'Please check your input';
                            } else {
                              isValidat = true;
                              return null;
                            }
                          },
                          (x) {
                            setState(() {
                              remarkCourse = x;
                            });
                          },
                          'Reason',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 35,
                      width: 80,
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
                      child: GestureDetector(
                          onTap: () {
                            getCourseWithdrawal();
                          },
                          child: Center(
                              child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          )))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//TODO: RequestType
  Future getCourseWithdrawalCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getCourseWithdrawalCourses'),
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
        setState(
          () {
            courseWithdrawalCoursesJson = json.decode(response.body)['data'];
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

//TODO: Final Request
  Future getCourseName() async {
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getCourseName'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'course_id': id,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            courseNameJson = json.decode(response.body);
          },
        );
        print(courseNameJson);
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

  Future getCourseWithdrawal() async {
    if (_remarkCourse.currentState.validate()) {
      _remarkCourse.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/courseWithdrawal'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'course_code': id,
          'course_title': courseNameJson['data']['CourseName'],
          'Remarks': remarkCourse,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
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
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: courseWithdrawalJson['message'],
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
            context, getCourseWithdrawalCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourseWithdrawalCourses);
      }
    }
  }
}
