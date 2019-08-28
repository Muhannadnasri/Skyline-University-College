import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(CourseAllocationMorning());

class CourseAllocationMorning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CourseAllocationMorningState();
  }
}

// Map<String, int> body;

class _CourseAllocationMorningState extends State<CourseAllocationMorning> {
  @override
  void initState() {
    super.initState();
    print(courseAllocationMorningJson);
    // courseAllocationMorningJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        appBar: appBarLogin(context, 'Class Morning'),
        body: courseAllocationMorningJson == null ||
                courseAllocationMorningJson.isEmpty
            ? exception(context, FontAwesomeIcons.exclamationTriangle,
                'No Class available')
            : Container(
                color: Colors.white,
                child: ListView.builder(
                  itemCount: courseAllocationMorningJson.length,
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
                                    courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session1']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session2']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session3']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session4']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session5']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session6']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session7']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session8']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
                                    courseAllocationMorningJson[index]
                                                    ['Session9']
                                                .toString() ==
                                            "null"
                                        ? ""
                                        : courseAllocationMorningJson[index]
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
