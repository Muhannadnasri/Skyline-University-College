import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(FinalTermResults());

class FinalTermResults extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FinalTermResultsState();
  }
}

// Map<String, int> body;

class _FinalTermResultsState extends State<FinalTermResults> {
  List finalTermMarksJson = [];
  List finalTermResultsJson = [];
  Map finalTermResultsMessageJson = {};

  @override
  void initState() {
    super.initState();

    finalTermResultsJson = [];
    finalTermMarksJson = [];

    getFinalTermResults();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      appBar: appBarLogin(context, 'Final Reults'),
      body: finalTermResultsJson == null ||
              finalTermMarksJson == null ||
              finalTermResultsJson == null && finalTermMarksJson == null
          ? exception(context, FontAwesomeIcons.exclamationTriangle,
              finalTermResultsMessageJson['message'])
          : Container(
              color: Colors.grey[300],
              child: ListView.builder(
                itemCount: finalTermResultsJson.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        elevation: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
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
                                padding: const EdgeInsets.only(
                                    left: 10, top: 10.0, bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Expanded(
                                        child: Text(
                                          finalTermResultsJson[index]
                                              ['Courses'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        getFinalTermMarks();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 5, right: 20),
                                        child: Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Course Code : ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    finalTermResultsJson[index]['Course Code'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Faculty Name : ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    finalTermResultsJson[index]['Faculty Name'],
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 10.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Semester : ',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    finalTermResultsJson[index]['Semester'],
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text('Grade'),
                                    Text(finalTermResultsJson[index]
                                        ['Over All Grade']),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Result'),
                                    Container(
                                      child: finalTermResultsJson[index]
                                                      ['Results']
                                                  .toString() ==
                                              "FAIL"
                                          ? Text(
                                              finalTermResultsJson[index]
                                                  ['Results'],
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          : finalTermResultsJson[index]
                                                          ['Results']
                                                      .toString() ==
                                                  "PASS"
                                              ? Text(
                                                  finalTermResultsJson[index]
                                                      ['Results'],
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                )
                                              : SizedBox,
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Status'),
                                    Text(finalTermResultsJson[index]['Status']),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text('Final Marks'),
                                    Text(finalTermMarksJson.isEmpty == true
                                        ? ''
                                        : finalTermMarksJson[index]
                                                ['Final Exam Marks']
                                            .toString()),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  Future getFinalTermResults() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getFinalTermResults"),
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
          finalTermResultsJson = json.decode(response.body)['data'];
          finalTermResultsMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getFinalTermResults);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getFinalTermResults);
      }
    }
  }

  Future getFinalTermMarks() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getFinalTermMarks"),
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
          finalTermMarksJson = json.decode(response.body)['data'];
        });
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getFinalTermResults);
      } else {
        showLoading(false, context);

        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getFinalTermResults);
      }
    }
  }
}
