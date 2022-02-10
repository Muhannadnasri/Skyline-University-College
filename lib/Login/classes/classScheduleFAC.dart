import 'dart:convert';

import 'package:flutter/material.dart';
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
  List courseAllocationJson = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getCourseAllocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarLogin(context, 'Course Faculty'),
        body: courseAllocationJson == null || courseAllocationJson.isEmpty
            ? exception(context, isLoading)
            : Container(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/courseAllocationMorning");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
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
                                  child: Center(
                                    child: Text(
                                      'Morning',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/courseAllocationEvening");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
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
                                  child: Center(
                                      child: Text(
                                    'Evening',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/courseAllocationWeekend");
                                },
                                child: Container(
                                  height: 50,
                                  width: 100,
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
                                  child: Center(
                                      child: Text(
                                    'Weekend',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ],
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
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 30,
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            courseAllocationJson[index]
                                                ['Course Description'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                _rowWidget('Course Code',
                                    courseAllocationJson[index]['Course Code']),
                                _rowWidget('Semester',
                                    courseAllocationJson[index]['Semester']),
                                _rowWidget('Batch Code',
                                    courseAllocationJson[index]['Batch Code']),
                                _rowWidget('Program',
                                    courseAllocationJson[index]['Program']),
                                _rowWidget('Level',
                                    courseAllocationJson[index]['Level']),
                                _rowWidget('Morning',
                                    courseAllocationJson[index]['Morning']),
                                _rowWidget('Evening',
                                    courseAllocationJson[index]['Evening']),
                                _rowWidget('Weekend',
                                    courseAllocationJson[index]['Weekend']),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }

  Widget _rowWidget(String text, data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text('$text : ' + ' ' + data.toString(),
                    style: TextStyle(
                        color: isDark(context) ? Colors.white : Colors.black)),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Future getCourseAllocationData() async {
    Future.delayed(Duration.zero, () {
      courseAllocationJson = [];
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.parse(
            "https://skylineportal.com/moappad/api/test/CourseAllocationData"),
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
          isLoading = false;
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
