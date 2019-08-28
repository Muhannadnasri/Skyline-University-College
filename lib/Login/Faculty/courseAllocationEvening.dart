import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(CourseAllocationEvening());

class CourseAllocationEvening extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseAllocationEveningState();
  }
}

// Map<String, int> body;

class _CourseAllocationEveningState extends State<CourseAllocationEvening> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, 'Class Evening'),
        body: courseAllocationEveningJson == null ||
                courseAllocationEveningJson.isEmpty
            ? exception(context, FontAwesomeIcons.exclamationTriangle,
                'No Class available')
            : Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: courseAllocationEveningJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
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
                              child: Row(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    courseAllocationEveningJson[index]
                                        ['SemName'],
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
                                  child: Text('WeekDays : '),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationEveningJson[index]
                                                    ['WeekDays']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationEveningJson[index]
                                                ['WeekDays']
                                            .toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
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
                                  child: Text("Session 1 : "),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationEveningJson[index]
                                                    ['Session1']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationEveningJson[index]
                                                ['Session1']
                                            .toString(),
                                  ),
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
                                  child: Text("Session 2 : "),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationEveningJson[index]
                                                    ['Session2']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationEveningJson[index]
                                                ['Session2']
                                            .toString(),
                                  ),
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
                                  child: Text('Session 3 : '.padRight(10)),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationEveningJson[index]
                                                    ['Session3']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationEveningJson[index]
                                                ['Session3']
                                            .toString(),
                                  ),
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
              ));
  }
}
