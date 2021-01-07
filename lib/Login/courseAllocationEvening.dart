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
    return Scaffold(
        appBar: appBarLogin(context, 'Class Evening'),
        body:

            // courseAllocationEveningJson == null ||
            //         courseAllocationEveningJson.isEmpty
            //     ? exception(context, isLoading)
            //     :

            Container(
          child: ListView.builder(
            itemCount: courseAllocationEveningJson.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            courseAllocationEveningJson[index]['SemName'],
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
                          child: Text('WeekDays : ',
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Expanded(
                          child: Text(
                            courseAllocationEveningJson[index]['WeekDays']
                                        .toString() ==
                                    "null"
                                ? ""
                                : courseAllocationEveningJson[index]['WeekDays']
                                    .toString(),
                            style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                    ),
                    _rowWidget(courseAllocationEveningJson[index]['Session1'],
                        'Session 1 : '),
                    _rowWidget(courseAllocationEveningJson[index]['Session2'],
                        'Session 2 : '),
                    _rowWidget(courseAllocationEveningJson[index]['Session3'],
                        'Session 3 : ')
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget _rowWidget(data, text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  data.toString() == "null" ? "" : text + ' ' + data.toString(),
                  style: TextStyle(
                      color: isDark(context) ? Colors.white : Colors.black),
                ),
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
}
