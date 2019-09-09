import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(AssessmentMarks());

class AssessmentMarks extends StatefulWidget {
  final String classID;

  final int index;

  AssessmentMarks({
    Key key,
    this.classID,
    this.index,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AssessmentMarksState();
  }
}

class _AssessmentMarksState extends State<AssessmentMarks> {
  List assessmentMarksJson = [];
  Map assessmentMarksJsonMessage = {};
  @override
  void initState() {
    super.initState();
    getStudentAssessmentMarks();
    assessmentMarksJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'Assessment Marks'),
      body: assessmentMarksJson == null
          ? exception(context, FontAwesomeIcons.exclamationTriangle,
              assessmentMarksJsonMessage['message'])
          : Container(
              color: Colors.grey[300],
              child: Container(
                color: Colors.grey[300],
                child: ListView.builder(
                  itemCount: assessmentMarksJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
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
                                height: 25,
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
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            assessmentMarksJson[index]['cname'],
                                            style:
                                                TextStyle(color: Colors.white),
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
                                    Text('Assessment Name : '),
                                    Expanded(
                                      child: Text(
                                        assessmentMarksJson[index]
                                                ['assessmenttools']
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
                                    Text("Marks : "),
                                    Expanded(
                                      child: Text(assessmentMarksJson[index]
                                              ['total']
                                          .toString()),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  void _showError(String msg, IconData icon) {
    showLoading(false, context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: Image.asset(
                'images/logo.png',
                height: 50,
              ),
              shape: SuperellipseShape(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new Icon(icon),
                    ),
                    new Text(msg)
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getStudentAssessmentMarks();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getStudentAssessmentMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/assessmentMarks"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'course_id': widget.classID,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          assessmentMarksJson = json.decode(response.body)['data'];
          assessmentMarksJsonMessage = json.decode(response.body);
        });

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        _showError("Time out from server", FontAwesomeIcons.hourglassHalf);
      } else {
        _showError("Sorry, we can't connect", Icons.perm_scan_wifi);
      }
    }
  }
}
