import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(CourseAllocationWeekend());

class CourseAllocationWeekend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseAllocationWeekendState();
  }
}

// Map<String, int> body;

class _CourseAllocationWeekendState extends State<CourseAllocationWeekend> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, 'Class  Weekday'),
        body: courseAllocationWeekendJson == null ||
                courseAllocationWeekendJson.isEmpty
            ? exception(context, FontAwesomeIcons.exclamationTriangle,
                'No Class available')
            : Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: courseAllocationWeekendJson.length,
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
                                    courseAllocationWeekendJson[index]
                                        ['WeekDays'],
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
                                  child: Text('section 1 : '),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session1']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("section 2 : "),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session2']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
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
                                  child: Text("section 3 : "),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session3']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
                                                ['Session3']
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
                                  child: Text('section 4 : '.padRight(10)),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session4']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
                                                ['Session4']
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
                                  child: Text('section 5 : '.padRight(10)),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session5']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
                                                ['Session5']
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
                                  child: Text('section 6 : '.padRight(10)),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session6']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
                                                ['Session6']
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
                                  child: Text('section 7 : '.padRight(10)),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session7']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
                                                ['Session7']
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
                                  child: Text('section 8 : '.padRight(10)),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session8']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
                                                ['Session8']
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
                                  child: Text('section 9 : '.padRight(10)),
                                ),
                                Expanded(
                                  child: Text(
                                    courseAllocationWeekendJson[index]
                                                    ['Session9']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationWeekendJson[index]
                                                ['Session9']
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
